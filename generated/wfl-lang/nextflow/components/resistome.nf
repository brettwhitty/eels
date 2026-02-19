#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: resistome
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    blast_file_list = ''
    db_file = ''
    db_file_list = ''
    filtered_blast_file = ''
    filtered_reads_file = ''
    identity_percentage = ''
    query_file = ''
    query_file_list = ''
    read_length_coverage = ''
    read_length_file = ''
    resistome_table = ''
    tmp_dir = ''
}

process store_read_and_source_map_query {
    script:
    """
    ${params.bin_dir}/store_read_dataset_info --input_file ${params.query_file} --input_file_list ${params.query_file_list} --output_file ${params.tmp_dir}/read_dataset_map_query.bin
    """
}

process store_read_and_source_map_db {
    script:
    """
    ${params.bin_dir}/store_read_dataset_info --input_file ${params.db_file} --input_file_list ${params.db_file_list} --output_file ${params.tmp_dir}/read_dataset_map_db.bin
    """
}

process fetch_read_length {
    script:
    """
    ${params.bin_dir}/get_read_length --input_file ${params.db_file} --input_file_list ${params.db_file_list} --read_dataset_info ${params.tmp_dir}/read_dataset_map_db.bin --output_file ${params.read_length_file}
    """
}

process filter_blast_output {
    script:
    """
    ${params.bin_dir}/filter_blast_output --read_length_file ${params.read_length_file} --blast_file_list ${params.blast_file_list} --output_file ${params.filtered_blast_file} --identity_percentage ${params.identity_percentage} --read_length_coverage ${params.read_length_coverage}
    """
}

process get_resistome_table {
    script:
    """
    ${params.bin_dir}/get_resistome_table --input_file ${params.filtered_blast_file} --read_dataset_info ${params.tmp_dir}/read_dataset_map_query.bin --output_file ${params.resistome_table}
    """
}

process get_filtered_reads {
    script:
    """
    ${params.bin_dir}/get_filtered_reads --input_file ${params.filtered_blast_file} --dataset_info ${params.tmp_dir}/read_dataset_map_query.bin --output_file ${params.filtered_reads_file}
    """
}

workflow {
    // Serial execution chain
    store_read_and_source_map_query()
    store_read_and_source_map_db()
    fetch_read_length()
    filter_blast_output()
    get_resistome_table()
    get_filtered_reads()
}
