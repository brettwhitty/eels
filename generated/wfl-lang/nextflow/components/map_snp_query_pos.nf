#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: map_snp_query_pos
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    merged_table = ''
    output_file = ''
    query_acc_map = ''
    raw_blast_list = ''
}

process map_query_pos {
    script:
    """
    ${params.bin_dir}/map_query_pos --query_acc_map ${params.query_acc_map} --merged_table ${params.merged_table} --raw_blast_list ${params.raw_blast_list} --output_file ${params.output_file}
    """
}

workflow {
    // Serial execution chain
    map_query_pos()
}
