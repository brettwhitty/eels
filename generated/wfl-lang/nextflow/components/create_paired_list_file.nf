#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: create_paired_list_file
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    list_file_1 = ''
    list_file_2 = ''
    other_args = ''
    output_directory = ''
    sample_info = ''
}

process create_paired_list_file {
    script:
    """
    ${params.bin_dir}/create_paired_list_file ${params.other_args} --listfile1 ${params.list_file_1} --listfile2 ${params.list_file_2} --samplefile ${params.sample_info} --outdir ${params.output_directory} \
        1>${params.output_directory}/create_paired_list_file.stdout \
        2>{{OUTPUT_DIRECTORY}}/create_paired_list_file.stderr
    """
}

workflow {
    // Serial execution chain
    create_paired_list_file()
}
