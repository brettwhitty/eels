#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: create_map_file
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_file_list = ''
    map_file = ''
}

process create_map_file {
    script:
    """
    ${params.bin_dir}/create_map_file --input_file_list ${params.input_file_list} --output_file ${params.map_file}
    """
}

workflow {
    // Serial execution chain
    create_map_file()
}
