#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fix_gene_symbols
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
    password = ''
    server = ''
    tbl_file = ''
    username = ''
}

process fix_gene_symbols {
    script:
    """
    ${params.bin_dir}/fix_gene_symbols --input_file ${params.i_file_path} --username ${params.username} --password ${params.password} --host ${params.server} --tbl_file ${params.tbl_file} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    fix_gene_symbols()
}
