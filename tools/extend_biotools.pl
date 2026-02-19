#!/usr/bin/env perl
# extend_biotools.pl - Look up unmapped open-source tools in bio.tools registry
# Extends biotools_mapping.json with new matches

use strict;
use warnings;
use JSON;
use LWP::UserAgent;
use URI::Escape;

my $eels = "$ENV{HOME}/repos/eels";

# Load existing mapping
open my $fh, '<', "$eels/data/biotools_mapping.json" or die $!;
my $bt = decode_json(do { local $/; <$fh> });
close $fh;

# Load full tool catalog
open $fh, '<', "$eels/data/tool_catalog_full.json" or die $!;
my $tools = decode_json(do { local $/; <$fh> });
close $fh;

# Get already-mapped biotoolsIDs
my %mapped_biotools;
my %mapped_components;
for my $m (@{$bt->{mapping}}) {
    $mapped_biotools{$m->{biotoolsID}} = 1 if $m->{matched};
    $mapped_components{$m->{component}} = 1;
}

# Known manual mappings for tools that don't search well
my %manual = (
    'blastall'      => 'blast',
    'blastn'        => 'blast',
    'blastp'        => 'blast',
    'blastpgp'      => 'blast',
    'blastx'        => 'blast',
    'tblastn'       => 'blast',
    'tblastx'       => 'blast',
    'hmmscan'       => 'hmmer3',
    'hmmsearch'     => 'hmmer3',
    'cmsearch'      => 'infernal',
    'bowtie-build'  => 'bowtie',
    'gsnap'         => 'gmap-gsnap',
    'gmap_setup'    => 'gmap-gsnap',
    'cuffmerge'     => 'cufflinks',
    'transeq'       => 'emboss',
    'fuzznuc'       => 'emboss',
    'iprscan'       => 'interproscan_5',
    'pfscan'        => 'pftools',
    'tbl2asn'       => 'tbl2asn',
    'prinseq-lite'  => 'prinseq',
    'quicktree'     => 'quicktree',
    'circleator'    => 'circleator',
    'fastx_quality_stats' => 'fastx-toolkit',
    'fastx_trimmer' => 'fastx-toolkit',
    'show-coords'   => 'mummer',
    'bmtool'        => 'bmtagger',
    'srprism'       => 'bmtagger',
    'uchime'        => 'uchime',
    'run_kSNP_v2'   => 'ksnp',
    'predotar'      => 'predotar',
    'gmhmme3'       => 'genemark',
    'gmhmmp'        => 'metagenemark',
    'SolSNP'        => 'solsnp',
    'alien_hunter'  => 'alien_hunter',
    'bank-transact' => 'amos',
    'toAmos'        => 'amos',
    'fastqToCA'     => 'celera_assembler',
    'sffToCA'       => 'celera_assembler',
    'runCA'         => 'celera_assembler',
);

my $ua = LWP::UserAgent->new(timeout => 10);

# Get open-source tools not yet mapped
my @open_source = grep { $_->{category_id} eq 'open_source' } @$tools;

my %already_checked;
my @new_mappings;
my @still_unmapped;

for my $tool (sort { $a->{name} cmp $b->{name} } @open_source) {
    my $name = $tool->{name};
    next if $already_checked{$name}++;

    # Skip things that aren't really tools
    next if $name =~ /^(java|python3|R|hadoop|psa2msa|syncdata\.sh|histogram_stacked|rasterize-svg|leech|metastats|cherrypie|scripture-beta2)$/;

    my $biotools_id;
    if (exists $manual{$name}) {
        $biotools_id = $manual{$name};
    } else {
        # Try bio.tools API
        my $query = uri_escape($name);
        my $resp = $ua->get("https://bio.tools/api/tool/?q=$query&format=json&page=1&size=5");
        if ($resp->is_success) {
            my $data = eval { decode_json($resp->decoded_content) };
            if ($data && $data->{list}) {
                for my $hit (@{$data->{list}}) {
                    my $hname = lc($hit->{name} // '');
                    my $hid = lc($hit->{biotoolsID} // '');
                    if ($hname eq lc($name) || $hid eq lc($name)) {
                        $biotools_id = $hit->{biotoolsID};
                        last;
                    }
                }
            }
        }
        sleep 0.3;  # rate limit
    }

    if ($biotools_id) {
        # Skip if already mapped under this ID
        next if $mapped_biotools{$biotools_id};

        printf "  MAPPED: %-30s -> %s\n", $name, $biotools_id;
        push @new_mappings, {
            tool_name    => $name,
            biotoolsID   => $biotools_id,
            bio_tools_url => "https://bio.tools/$biotools_id",
            source       => 'extend_biotools.pl',
            components   => $tool->{components},
        };
        $mapped_biotools{$biotools_id} = 1;
    } else {
        printf "  UNMAPPED: %s\n", $name;
        push @still_unmapped, $name;
    }
}

# Now integrate new mappings into the existing biotools_mapping.json
# For each new tool mapping, find components that use it and add to mapping array
open $fh, '<', "$eels/data/biotools_mapping.json" or die $!;
$bt = decode_json(do { local $/; <$fh> });
close $fh;

my $added = 0;
for my $nm (@new_mappings) {
    for my $comp (@{$nm->{components} // []}) {
        next if $mapped_components{$comp};

        # Fetch bio.tools info
        my $resp = $ua->get("https://bio.tools/api/tool/$nm->{biotoolsID}/?format=json");
        my $info = {};
        if ($resp->is_success) {
            $info = eval { decode_json($resp->decoded_content) } || {};
        }
        sleep 0.3;

        push @{$bt->{mapping}}, {
            component     => $comp,
            biotoolsID    => $nm->{biotoolsID},
            tool_name     => $info->{name} // $nm->{tool_name},
            bio_tools_url => $nm->{bio_tools_url},
            homepage      => $info->{homepage} // '',
            matched       => JSON::true,
            tool_steps    => [{ name => $nm->{tool_name}, executable => '', category => 'tool_execution', idx => 0 }],
        };
        $mapped_components{$comp} = 1;
        $added++;

        # Remove from unmapped
        $bt->{unmapped} = [grep { $_ ne $comp } @{$bt->{unmapped}}];
    }
}

# Update summary
my $unique = {};
for my $m (@{$bt->{mapping}}) {
    $unique->{$m->{biotoolsID}} = 1 if $m->{matched};
}
$bt->{summary} = {
    total_components   => $bt->{summary}{total_components},
    mapped_components  => scalar(grep { $_->{matched} } @{$bt->{mapping}}),
    unmapped_components => scalar(@{$bt->{unmapped}}),
    unique_biotools    => scalar(keys %$unique),
    biotools_found     => scalar(keys %$unique),
};

# Write updated mapping
open my $out, '>', "$eels/data/biotools_mapping.json" or die $!;
print $out JSON->new->pretty->canonical->encode($bt);
close $out;

printf "\nResults: %d new tool->component mappings added, %d still unmapped open-source tools\n", $added, scalar(@still_unmapped);
printf "Total mapped components: %d, unique bio.tools: %d\n",
    $bt->{summary}{mapped_components}, $bt->{summary}{unique_biotools};
