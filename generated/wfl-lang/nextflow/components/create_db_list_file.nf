#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: create_db_list_file
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_file = ''
    output_directory = ''
}

process create_db_list_file {
    script:
    """
    ${params.bin_dir}/create_db_list_file --input_file ${params.input_file} --output_dir ${params.output_directory} \
        1>${params.output_directory}/${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    create_db_list_file()
}
