#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: snp_verify
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
}

process snp_verify {
    script:
    """
    ${params.bin_dir}/snp_verify --input_list ${params.i_file_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    snp_verify()
}
