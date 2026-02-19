#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: filter_merged_table
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
    query_list = ''
}

process filter_merged_table {
    script:
    """
    ${params.bin_dir}/filter_merged_table --merged_table ${params.i_file_path} --query_list ${params.query_list} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    filter_merged_table()
}
