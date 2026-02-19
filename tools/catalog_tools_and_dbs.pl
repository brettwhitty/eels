#!/usr/bin/env perl
# catalog_tools_and_dbs.pl - Parse software.config and component JSON to build
# comprehensive catalogs of tool executables and reference databases
# Applies Brett's executable taxonomy (issue #9 comment):
#   1. OS/System tools  2. Custom Perl scripts (TIGR/JCVI/IGS)
#   3. Custom binaries (TIGR/JCVI/IGS)  4. Open-source public tools
#   5. Closed-source private tools  6. Legacy tools  7. Workflow constructs
use strict;
use warnings;
use JSON;
use File::Slurp qw(read_file write_file);
use File::Basename;

my $eels_dir = "$ENV{HOME}/repos/eels";
my $sw_config = "$eels_dir/data/reference/software.config";
my $comp_dir  = "$eels_dir/data/components";
my $biotools  = "$eels_dir/data/biotools_mapping.json";

# Parse software.config
my %sections;      # component => { var => path }
my %all_execs;     # normalized_name => { path, components[], type }
my %all_dbs;       # var_name => { path, components[], description }
my $current_section = '';

open my $fh, '<', $sw_config or die "Cannot open $sw_config: $!";
while (<$fh>) {
    chomp;
    s/^\s+//; s/\s+$//;
    next if /^$/ || /^;/;
    if (/^\[(.+)\]/) {
        $current_section = $1;
        next;
    }
    if (/^\$;(\w+)\$;\s*=\s*(.*)/) {
        my ($var, $val) = ($1, $2);
        $val =~ s/\s+$//;
        $sections{$current_section}{$var} = $val;

        # Classify as exec or db
        my $is_exec = ($var =~ /EXEC|_BIN$|_PATH$|_DIR$/ && $var !~ /DB|LIB|PROFILES|LOOKUP|TAXONOMY|TAX_|ROLES|ENZYME|SQLITE|FASTA|ALIAS|FUNCTION|DESC|MEMBERS|CAT$|MAPPING|STOCKHOLM|CM_FILE/);
        my $is_db = ($var =~ /DB|LIB|PROFILES|LOOKUP|TAXONOMY|TAX_|ROLES|ENZYME|SQLITE|FASTA_NR|RAPSEARCH_|EGGNOG|CM_FILE|RFAM|RNA_LIB|SIMPLE_REPEAT|PRIAM|NCBI_BLAST_N|MATRIX|CHAR_DB|COGS_|HMM_ALL|HMM_LIB|HMM_INFO/ && $var !~ /EXEC|_BIN$/);

        my $comp = '';
        $comp = $1 if $current_section =~ /component\s+(.+)/;

        if ($is_exec && $val =~ /\S/) {
            my $name = basename($val);
            $name =~ s/\.pl$//; $name =~ s/\.sh$//; $name =~ s/\.jar$//;
            # Skip directory-only paths (BIN, DIR vars that are just directories)
            next if $name eq 'bin' || $name eq 'latest' || $val =~ m{/$};
            # Skip if var name ends in _DIR and value looks like a directory
            next if $var =~ /_DIR$/ && !($val =~ /\.\w+$/);
            push @{$all_execs{$name}{components}}, $comp || $current_section;
            $all_execs{$name}{path} = $val unless $all_execs{$name}{path};
            $all_execs{$name}{var} = $var;
        }
        if ($is_db && $val =~ /\S/) {
            push @{$all_dbs{$var}{components}}, $comp || $current_section;
            $all_dbs{$var}{path} = $val unless $all_dbs{$var}{path};
        }
    }
}
close $fh;

# Load biotools mapping for cross-reference
open my $bt_fh, '<', $biotools or die "Cannot open $biotools: $!";
my $bt_data = decode_json(do { local $/; <$bt_fh> });
close $bt_fh;
my %biotools_by_component;
for my $m (@{$bt_data->{mapping}}) {
    next unless $m->{matched};
    $biotools_by_component{$m->{component}} = {
        id => $m->{biotoolsID},
        name => $m->{tool_name},
        url => $m->{bio_tools_url},
    };
}

# Classify executables using Brett's taxonomy
my %taxonomy_rules = (
    # Category 1: OS/System tools
    os_system => [qw(cat cp mv rm find sort tail zcat env mkdir chmod gzip gunzip tar sed awk grep cut head wc touch ln)],
    # Category 4: Open-source public (from bio.tools + known)
    open_source => [qw(
        blastall blastp blastn blastx tblastn tblastx megablast rpsblast blastpgp formatdb makeblastdb
        hmmpfam hmmscan hmmls hmmsearch
        glimmer3 glimmerhmm genemark gmhmme3 genemarkes prodigal augustus geneid genewise genezilla snap fgenesh genscan
        tRNAscan-SE rnammer cmsearch aragorn
        bwa bowtie bowtie-build tophat cufflinks cuffcompare cuffdiff cuffmerge
        samtools nucmer show-coords delta-filter show-snps mummer
        muscle clustalw exonerate
        RepeatMasker
        mothur
        velvet velveth velvetg SOAPdenovo SPAdes
        signalp tmhmm targetp LipoP predotar psort
        R java python3
        rapsearch FastOrtho mcl
        trf phobos antigenic fuzznuc transeq getorf pepstats
        fastx_quality_stats fastx_trimmer
        runCA sffToCA fastqToCA toAmos bank-transact
        crossbow hadoop
        FastTree quicktree dnadist_worker dnadist_combiner
        iprscan ps_scan pfscan psa2msa
        bmtagger bmtool srprism
        prinseq-lite
        circleator rasterize-svg
        usearch uchime uclust
        rdp_classifier
        tbl2asn
        gmap_setup gsnap scripture
        alien_hunter
        bepipred
    )],
    # Category 2: Custom Perl scripts (TIGR/JCVI/IGS)
    custom_perl => [qw(
        extCollapse filter
        replace_fasta_headers hmmpfam2htab hmmpfam32htab
        blast2btab blast2bsml
        MSF2Bsml
        train_for_glimmer3 train_for_glimmer3_iteration
        run_cmsearch run_blast_plus run_bmtagger run_genemark-es run_velvet_optimiser run_spades
        bam2bigwig bam2coverage bam2sam bam_merge sam2bam
        validate_clustalw_output
        trf_wrapper bwa_wrapper
        prepare_for_genewise_best_loc
        get_seq_by_metagene
        signalp_graphics_rename
        Create_Qiime_tables
        lgt_bwa lgt_build_index lgt_filter_reads lgt_bwa_post_process
        nucmer-snp2merged replace_maf_ids
        mothur_unique_seq_limit
        assign_ec_from_rps
        velveth_post_processing velvetg_pre_processing velvetg_post_processing
        bwa_index bwa_align
    )],
    # Category 3: Custom binaries (TIGR/JCVI/IGS)
    custom_binary => [qw(dps ext nap dds gap2 praze cluster skiff fullphat phobos_64bit seg xdformat elph mga_linux_ia32)],
    # Category 5: Closed-source private
    closed_source => [qw(fgenesh)],
);

# Build reverse lookup
my %exec_category;
for my $cat (keys %taxonomy_rules) {
    for my $tool (@{$taxonomy_rules{$cat}}) {
        $exec_category{lc $tool} = $cat;
    }
}

# Classify each executable
for my $name (keys %all_execs) {
    my $path = $all_execs{$name}{path};
    my $lc = lc $name;

    if ($exec_category{$lc}) {
        $all_execs{$name}{category} = $exec_category{$lc};
    } elsif ($path =~ m{^/(usr/)?bin/} && $name !~ /blast|hmm|samtools/) {
        $all_execs{$name}{category} = 'os_system';
    } elsif ($path =~ /\.pl$/ || $path =~ /perl/) {
        $all_execs{$name}{category} = 'custom_perl';
    } elsif ($path =~ /\.sh$/) {
        $all_execs{$name}{category} = 'custom_perl';  # shell wrappers count as custom
    } elsif ($path =~ m{/devel/ANNOTATION/|/local/projects/|/home/}) {
        $all_execs{$name}{category} = 'custom_binary';
    } elsif ($path =~ m{/usr/local/packages/|/opt/}) {
        $all_execs{$name}{category} = 'open_source';
    } else {
        $all_execs{$name}{category} = 'unknown';
    }
}

# Category labels
my %cat_labels = (
    os_system     => '1. OS/System tools',
    custom_perl   => '2. Custom Perl scripts/wrappers (TIGR/JCVI/IGS)',
    custom_binary => '3. Custom binaries (TIGR/JCVI/IGS)',
    open_source   => '4. Open-source public tools',
    closed_source => '5. Closed-source private tools',
    legacy        => '6. Legacy tools',
    workflow      => '7. Workflow constructs/system aliases',
    unknown       => '?. Unclassified',
);

# Classify databases
my %db_categories;
for my $var (keys %all_dbs) {
    my $path = $all_dbs{$var}{path};
    my $cat;
    if ($path =~ /panda|AllGroup/) { $cat = 'Sequence DB (PANDA/AllGroup)'; }
    elsif ($path =~ /ncbi.*nr|ncbi.*nt/) { $cat = 'Sequence DB (NCBI nr/nt)'; }
    elsif ($path =~ /uniref|uniprot/) { $cat = 'Sequence DB (UniRef/UniProt)'; }
    elsif ($path =~ /coding_hmm/) { $cat = 'Domain/Family DB (coding_hmm - Pfam+TIGRFAMs)'; }
    elsif ($path =~ /TIGRFAMs|tigr_roles/) { $cat = 'Domain/Family DB (TIGRFAMs/TIGR Roles)'; }
    elsif ($path =~ /PANTHER/) { $cat = 'Domain/Family DB (PANTHER)'; }
    elsif ($path =~ /Rfam/) { $cat = 'RNA DB (Rfam)'; }
    elsif ($path =~ /RDPII/) { $cat = 'RNA DB (RDP)'; }
    elsif ($path =~ /priam/) { $cat = 'Enzyme DB (PRIAM)'; }
    elsif ($path =~ /prosite/) { $cat = 'Domain/Family DB (PROSITE)'; }
    elsif ($path =~ /eggnog/) { $cat = 'Orthology DB (eggNOG)'; }
    elsif ($path =~ /COG/) { $cat = 'Orthology DB (COG)'; }
    elsif ($path =~ /taxonomy|taxdump/) { $cat = 'Taxonomy DB (NCBI)'; }
    elsif ($path =~ /enzyme\.dat/) { $cat = 'Enzyme DB (ExPASy)'; }
    elsif ($path =~ /tchar/) { $cat = 'Custom DB (tchar - TIGR/JCVI)'; }
    elsif ($path =~ /RepeatMasker/) { $cat = 'Repeat DB (RepeatMasker)'; }
    elsif ($path =~ /AAT|matrices/) { $cat = 'Scoring Matrix (AAT)'; }
    else { $cat = 'Other'; }
    $all_dbs{$var}{category} = $cat;
}

# Output: tool_catalog.json
my @tool_catalog;
for my $name (sort keys %all_execs) {
    my $e = $all_execs{$name};
    my @comps = @{$e->{components} || []};
    @comps = grep { $_ ne '' } @comps;
    my $bt = undef;
    for my $c (@comps) {
        if ($biotools_by_component{$c}) {
            $bt = $biotools_by_component{$c};
            last;
        }
    }
    push @tool_catalog, {
        name => $name,
        path => $e->{path},
        category => $cat_labels{$e->{category}} || $e->{category},
        category_id => $e->{category},
        components => \@comps,
        ($bt ? (biotools => $bt) : ()),
    };
}

# Output: database_catalog.json
my @db_catalog;
for my $var (sort keys %all_dbs) {
    my $d = $all_dbs{$var};
    my @comps = @{$d->{components} || []};
    @comps = grep { $_ ne '' } @comps;
    push @db_catalog, {
        variable => $var,
        path => $d->{path},
        category => $d->{category},
        components => \@comps,
    };
}

# Write outputs
my $json = JSON->new->pretty->canonical;
write_file("$eels_dir/data/tool_catalog.json", $json->encode(\@tool_catalog));
write_file("$eels_dir/data/database_catalog.json", $json->encode(\@db_catalog));

# Print summary
my %cat_counts;
$cat_counts{$_->{category_id}}++ for @tool_catalog;
print "=== Tool Catalog ===\n";
for my $c (sort keys %cat_counts) {
    printf "  %-50s %d\n", $cat_labels{$c} || $c, $cat_counts{$c};
}
print "  Total: " . scalar(@tool_catalog) . "\n\n";

my %db_cat_counts;
$db_cat_counts{$_->{category}}++ for @db_catalog;
print "=== Database Catalog ===\n";
for my $c (sort keys %db_cat_counts) {
    printf "  %-50s %d\n", $c, $db_cat_counts{$c};
}
print "  Total: " . scalar(@db_catalog) . "\n";
