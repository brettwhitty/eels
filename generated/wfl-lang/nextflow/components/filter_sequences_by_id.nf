#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: filter_sequences_by_id
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    filter_mode = ''
    group_number = ''
    id_column_num = ''
    id_file = ''
    id_file_list = ''
    input_format = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
}

process filter {
    script:
    """
    ${params.bin_dir}/filter_sequences_by_id --input_file ${params.i_file_path} --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.filtered.${params.input_format} --id_file ${params.id_file} --id_file_list ${params.id_file_list} --mode ${params.filter_mode} --format ${params.input_format} --id_column_num ${params.id_column_num}
    """
}

workflow {
    // Serial execution chain
    filter()
}
