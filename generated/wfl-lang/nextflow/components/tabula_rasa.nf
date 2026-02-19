#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: tabula_rasa
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    input_command = ''
    iterator_name = ''
    i_dir = ''
    i_file_base = ''
    i_file_ext = ''
    i_file_name = ''
    i_file_path = ''
    output_directory = ''
}

process tabula_rasa {
    script:
    """
    ${params.bin_dir}/tabula_rasa --input_command '${params.input_command}' --iter_file_path ${params.i_file_path} --iter_file_base ${params.i_file_base} --iter_file_ext ${params.i_file_ext} --iter_file_name ${params.i_file_name} --iter_dir ${params.i_dir} --output_directory ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    tabula_rasa()
}
