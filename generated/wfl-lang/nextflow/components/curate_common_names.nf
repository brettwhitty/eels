#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: curate_common_names
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    host = ''
    i_file_path = ''
    no_change = ''
    password = ''
    password_file = ''
    username = ''
}

process curate_common_names {
    script:
    """
    ${params.bin_dir}/curate_common_names --username ${params.username} --password ${params.password} --password_file ${params.password_file} --host ${params.host} --input_map_file ${params.i_file_path} --no_change ${params.no_change} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    curate_common_names()
}
