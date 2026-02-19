#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: update_ec_numbers
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    ec_dat_file = ''
    host = ''
    i_file_path = ''
    no_change = ''
    password = ''
    password_file = ''
    username = ''
}

process update_ec_numbers {
    script:
    """
    ${params.bin_dir}/update_ec_numbers --username ${params.username} --password ${params.password} --password_file ${params.password_file} --server ${params.host} --database_file ${params.i_file_path} --input_ec_dat ${params.ec_dat_file} --no_change ${params.no_change} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    update_ec_numbers()
}
