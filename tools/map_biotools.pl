#!/usr/bin/env perl
use strict;
use warnings;
use JSON;
use File::Slurp;
use Getopt::Long;

my $output;
my $cache_dir = "$ENV{HOME}/repos/eels/data/biotools_cache";
my $steps_dir = "$ENV{HOME}/repos/eels/data/categorized_steps";

GetOptions(
    'output|o=s'    => \$output,
    'cache-dir=s'   => \$cache_dir,
    'steps-dir=s'   => \$steps_dir,
);

mkdir $cache_dir unless -d $cache_dir;

# Curated mapping: Ergatis component name → bio.tools ID
# Multiple components can map to the same tool
my %COMPONENT_TO_BIOTOOLS = (
    # BLAST family
    'ncbi-blastp'           => 'blast',
    'ncbi-blastn'           => 'blast',
    'ncbi-blastn_compress'  => 'blast',
    'ncbi-blastx'           => 'blast',
    'ncbi-tblastn'          => 'blast',
    'ncbi-tblastx'          => 'blast',
    'ncbi-blastall'         => 'blast',
    'megablast'             => 'blast',
    'psiblast'              => 'blast',
    'rpsblast'              => 'blast',
    'blastn_plus'           => 'blast',
    'blastp_plus'           => 'blast',
    'tblastn_plus'          => 'blast',
    'wu-blastn'             => 'blast',  # WU-BLAST is discontinued, map to BLAST
    'wu-blastp'             => 'blast',
    'wu-blastx'             => 'blast',
    'wu-tblastn'            => 'blast',
    'blast2go'              => 'blast2go',
    
    # HMMER family
    'hmmer'                 => 'hmmer3',
    'hmmpfam'               => 'HMMER2',
    'hmmpfam3'              => 'hmmer3',
    'hmmls'                 => 'HMMER2',
    'tmhmm'                 => 'tmhmm',
    
    # Gene finding
    'glimmer3'              => 'glimmer',
    'glimmer3_cloud'        => 'glimmer',
    'pseudomolecule2glimmer3' => 'glimmer',
    'train_for_glimmer3_iteration' => 'glimmer',
    'glimmerHMM'            => 'glimmerhmm',
    'prodigal'              => 'prodigal',
    'genemark'              => 'genemark',
    'genemark-es'           => 'genemark',
    'metagenemark'          => 'metagenemark',
    'metagene'              => 'metagenemark',
    'augustus'               => 'augustus',
    'snap'                  => 'snap',
    'getorf'                => 'emboss',
    
    # RNA
    'tRNAscan-SE'           => 'trnascan-se',
    'tRNAscan-SE_compress'  => 'trnascan-se',
    'RNAmmer'               => 'rnammer',
    'rrna_hmm_fs'           => 'rnammer',
    'aragorn'               => 'aragorn',
    'infernal'              => 'Infernal',
    
    # Alignment
    'bowtie'                => 'bowtie',
    'bowtie_build'          => 'bowtie',
    'bwa'                   => 'bwa',
    'bwa_align'             => 'bwa',
    'bwa_index'             => 'bwa',
    'bwa_mem'               => 'bwa',
    'lgt_bwa'               => 'bwa',
    'lgt_bwa_fq'            => 'bwa',
    'lgt_build_bwa_index'   => 'bwa',
    'tophat'                => 'tophat',
    'clustalw'              => 'clustalw',
    'muscle'                => 'muscle',
    
    # Sequence analysis
    'signalp'               => 'signalp',
    'lipop'                 => 'lipop',
    'antigenic'             => 'emboss',
    'pepstats'              => 'emboss',
    'ps_scan'               => 'ps_scan',
    
    # Assembly
    'velvet'                => 'velvet',
    'velvet_optimiser'      => 'velvet',
    'SPAdes'                => 'spades',
    'celera-assembler'      => 'celera_assembler',
    'celera-assembler-distributed' => 'celera_assembler',
    'amoscmp'               => 'amos',
    
    # SAMtools / BAM
    'samtools_alignment_stats' => 'samtools',
    'bam2bigwig'            => 'samtools',
    'bam2coverage'          => 'samtools',
    'bam2sam'               => 'samtools',
    'bam_merge'             => 'samtools',
    
    # RNA-Seq
    'cufflinks'             => 'cufflinks',
    'cuffdiff'              => 'cufflinks',
    'cuffmerge'             => 'cufflinks',
    'cuffcompare'           => 'cufflinks',
    
    # Mothur
    'mothur_align_seqs'     => 'mothur',
    'mothur_chimera_slayer' => 'mothur',
    'mothur_classify_seqs'  => 'mothur',
    'mothur_cluster'        => 'mothur',
    'mothur_collect_single' => 'mothur',
    'mothur_dist_seqs'      => 'mothur',
    'mothur_filter_seqs'    => 'mothur',
    'mothur_get_oturep'     => 'mothur',
    'mothur_rarefaction_single' => 'mothur',
    'mothur_read_otu'       => 'mothur',
    'mothur_screen_seqs'    => 'mothur',
    'mothur_summary'        => 'mothur',
    'mothur_tree_shared'    => 'mothur',
    'mothur_trim_seqs'      => 'mothur',
    'mothur_unique_seq_limit' => 'mothur',
    'mothur_unique_seqs'    => 'mothur',
    
    # QIIME
    'core_qiime'           => 'qiime',
    
    # Repeat finding
    'repeatmasker'          => 'repeatmasker',
    
    # Protein domain
    'interpro'              => 'interpro',
    
    # Mugsy
    'mugsyalign'            => 'mugsy',
    'mugsyalign_distributed_work' => 'mugsy',
    
    # Mauve
    'mauve_assembly_metrics' => 'mauve',
    
    # Misc well-known
    'exonerate'             => 'exonerate',
    'fastortho_distributed' => 'fastortho',
    'nucmer'                => 'mummer',
    'nucmer_snps'           => 'mummer',
    'nucmer-snp2merged'     => 'mummer',
    'psortb'                => 'psortb',

    # Additional mappings
    'glimmerHMM'            => 'glimmer-hmm',
    'RAPSearch2'            => 'rapsearch',
    'bepipred'              => 'bepipred',
    'bmtagger'              => 'bmtagger',
    'bmtagger_index'        => 'bmtagger',
    'crossbow'              => 'crossbow',
    'deseq'                 => 'deseq',
    'edgeR'                 => 'edger',
    'fast_tree'             => 'fasttree',
    'fastqc_stats'          => 'fastqc',
    'fgenesh'               => 'fgenesh',
    'geneid'                => 'geneid',
    'genewise'              => 'genewise',
    'genezilla'             => 'genezilla',
    'genscan'               => 'genscan',
    'genscan-plus'          => 'genscan',
    'cuffdiff'              => 'cufflinks',
    'cuffdiff_filter'       => 'cufflinks',
    'cuffmerge'             => 'cufflinks',
    'cuffcompare'           => 'cufflinks',
    'cummerbund'            => 'cummerbund',
    'targetp'               => 'targetp',
    'trf'                   => 'trf',
    'usearch'               => 'usearch',
    'soapdenovo'            => 'soapdenovo',
    'formatdb'              => 'blast',
    'sam2bam'               => 'samtools',
    'samtools_file_convert' => 'samtools',
    'samtools_merge'        => 'samtools',
    'samtools_reference_index' => 'samtools',
    'priam_ec_assignment'   => 'priam_search',
);

# Gather all components and their steps
my %component_data;
opendir(my $dh, $steps_dir) or die "Can't open $steps_dir: $!";
while (my $f = readdir($dh)) {
    next unless $f =~ /\.json$/;
    my $data = from_json(read_file("$steps_dir/$f"));
    my $comp = $data->{component};
    $component_data{$comp} = $data;
}
closedir($dh);

# Query bio.tools API for each unique bio.tools ID
my %biotools_cache;
my %unique_ids;
for my $comp (keys %COMPONENT_TO_BIOTOOLS) {
    $unique_ids{$COMPONENT_TO_BIOTOOLS{$comp}} = 1;
}

for my $btid (sort keys %unique_ids) {
    my $cache_file = "$cache_dir/$btid.json";
    
    if (-f $cache_file) {
        eval { $biotools_cache{$btid} = from_json(read_file($cache_file)); };
        next if $biotools_cache{$btid};
    }
    
    print STDERR "Querying bio.tools for: $btid\n";
    my $url = "https://bio.tools/api/tool/$btid/?format=json";
    my $response = `curl -s "$url" 2>/dev/null`;
    
    eval {
        my $data = from_json($response);
        if ($data->{biotoolsID}) {
            $biotools_cache{$btid} = {
                biotoolsID  => $data->{biotoolsID},
                name        => $data->{name},
                homepage    => $data->{homepage} || '',
                description => $data->{description} || '',
                topic       => [ map { $_->{term} } @{$data->{topic} || []} ],
                function    => [ map {
                    {
                        operation => [ map { $_->{term} } @{$_->{operation} || []} ],
                        input     => [ map { { term => $_->{data}{term} || '', format => [ map { $_->{term} } @{$_->{format} || []} ] } } @{$_->{input} || []} ],
                        output    => [ map { { term => $_->{data}{term} || '', format => [ map { $_->{term} } @{$_->{format} || []} ] } } @{$_->{output} || []} ],
                    }
                } @{$data->{function} || []} ],
                license     => $data->{license} || '',
            };
            write_file($cache_file, to_json($biotools_cache{$btid}, { utf8 => 1, pretty => 1 }));
        }
    };
    if ($@) {
        print STDERR "  Failed: $@\n";
    }
    
    # Rate limit
    select(undef, undef, undef, 0.3);
}

# Build the mapping
my @mapping;
my %tools_seen;

for my $comp (sort keys %COMPONENT_TO_BIOTOOLS) {
    next unless exists $component_data{$comp};
    
    my $btid = $COMPONENT_TO_BIOTOOLS{$comp};
    my $bt = $biotools_cache{$btid};
    
    my @tool_steps;
    for my $step (@{$component_data{$comp}{steps} || []}) {
        push @tool_steps, $step if $step->{category} eq 'tool_execution';
    }
    
    push @mapping, {
        component    => $comp,
        biotoolsID   => $bt ? $bt->{biotoolsID} : $btid,
        tool_name    => $bt ? $bt->{name} : $btid,
        homepage     => $bt ? $bt->{homepage} : '',
        bio_tools_url => $bt ? "https://bio.tools/$bt->{biotoolsID}" : '',
        matched      => $bt ? JSON::true : JSON::false,
        tool_steps   => \@tool_steps,
    };
    
    $tools_seen{$btid} = 1;
}

# Also list unmapped components
my @unmapped;
for my $comp (sort keys %component_data) {
    next if exists $COMPONENT_TO_BIOTOOLS{$comp};
    push @unmapped, $comp;
}

my $result = {
    summary => {
        total_components     => scalar(keys %component_data),
        mapped_components    => scalar(@mapping),
        unmapped_components  => scalar(@unmapped),
        unique_biotools      => scalar(keys %tools_seen),
        biotools_found       => scalar(grep { $biotools_cache{$_} } keys %tools_seen),
    },
    mapping  => \@mapping,
    unmapped => \@unmapped,
    biotools => { map { $_ => $biotools_cache{$_} } keys %biotools_cache },
};

my $json_out = to_json($result, { utf8 => 1, pretty => 1, canonical => 1 });

if (defined $output) {
    write_file($output, $json_out);
    print STDERR "Wrote mapping to $output\n";
} else {
    print $json_out;
}
