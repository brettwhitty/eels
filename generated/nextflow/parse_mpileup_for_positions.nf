#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: parse_mpileup_for_positions
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_mpileup_file = ''
    i_query = ''
    i_version = ''
    mapped_positions = ''
    output_directory = ''
}

process parse_mpileup {
    script:
    """
    ${params.bin_dir}/parse_mpileup --mpileup ${params.i_mpileup_file} --mapped_positions ${params.mapped_positions} --query ${params.i_query} --version ${params.i_version} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_query}.qc.txt \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_query}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_QUERY}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    parse_mpileup()
}
