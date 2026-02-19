#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: split_file
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_file = ''
    input_file_list = ''
    lines_per_file = ''
    num_files = ''
    output_directory = ''
    prefix = ''
}

process split_file {
    script:
    """
    ${params.bin_dir}/split_file --input_files ${params.input_file} --input_file_list ${params.input_file_list} --output_directory ${params.output_directory} --lines_per_file ${params.lines_per_file} --num_files ${params.num_files} --prefix ${params.prefix} \
        1>${params.output_directory}/split_file.stdout \
        2>{{OUTPUT_DIRECTORY}}/split_file.stderr
    """
}

process Create_file_list {
    script:
    """
    find ${params.output_directory} -name '*.splitlist'|sort -n \
        1>${params.output_list} \
        2>{{OUTPUT_DIRECTORY}}/split_file.stderr
    """
}

workflow {
    // Serial execution chain
    split_file()
    Create_file_list()
}
