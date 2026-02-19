#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bam2coverage
// Generated from Ergatis component JSON by EELS

params {
    bam_file = ''
    bin_dir = ''
    features_only = ''
    feature_type = ''
    genome_only = ''
    gff3_file = ''
    other_args = ''
    output_directory = ''
    output_stub = ''
    stranded = ''
    total_mapped_reads = ''
}

process bam2coverage {
    script:
    """
    ${params.bin_dir}/bam2coverage ${params.other_args} --bam_file ${params.bam_file} --stranded ${params.stranded} --gff3_file ${params.gff3_file} --feature_type ${params.feature_type} --output_stub ${params.output_stub} --output_dir ${params.output_directory} --genome_only ${params.genome_only} --features_only ${params.features_only} --total_mapped_reads ${params.total_mapped_reads} \
        1>${params.output_directory}/bam2coverage.stdout \
        2>{{OUTPUT_DIRECTORY}}/bam2coverage.stderr
    """
}

workflow {
    // Serial execution chain
    bam2coverage()
}
