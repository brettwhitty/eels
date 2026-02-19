#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: gff3_to_annotab
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    group_number = ''
    id_attr = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    parse_ec = ''
    parse_gene_symbol = ''
    parse_go = ''
    type = ''
}

process gff3_to_annotab {
    script:
    """
    ${params.bin_dir}/gff3_to_annotab --type ${params.type} --id_attr ${params.id_attr} --input_file ${params.i_file_path} --output_annotab ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.annotab --parse_GO ${params.parse_go} --parse_EC ${params.parse_ec} --parse_gene_symbol ${params.parse_gene_symbol} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    gff3_to_annotab()
}
