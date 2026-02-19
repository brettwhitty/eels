#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fastqc_stats
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    fastqc_bin_dir = ''
    group_number = ''
    input_file_1 = ''
    input_file_2 = ''
    iterator_name = ''
    other_parameters = ''
    output_directory = ''
}

process fastqc_stats {
    script:
    """
    ${params.bin_dir}/fastqc_stats --seq1file ${params.input_file_1} --seq2file '${params.input_file_2}' --args ${params.other_parameters} --fastqc_bin_dir ${params.fastqc_bin_dir} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/fastqc_stats.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/fastqc_stats.stderr
    """
}

workflow {
    // Serial execution chain
    fastqc_stats()
}
