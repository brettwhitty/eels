#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: samtools_alignment_stats
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    other_args = ''
    output_directory = ''
    samtools_bin_dir = ''
}

process samtools_alignment_stats {
    script:
    """
    ${params.bin_dir}/samtools_alignment_stats ${params.other_args} --infile ${params.i_file_path} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --samtools_bin_dir ${params.samtools_bin_dir} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/samtools_alignment_stats.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/samtools_alignment_stats.stderr
    """
}

workflow {
    // Serial execution chain
    samtools_alignment_stats()
}
