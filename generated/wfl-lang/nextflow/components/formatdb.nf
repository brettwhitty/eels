#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: formatdb
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database_name = ''
    formatdb_exec = ''
    input_files = ''
    input_file_list = ''
    output_directory = ''
    protein = ''
}

process formatdb {
    script:
    """
    ${params.bin_dir}/formatdb --input_file_list ${params.input_file_list} --input_files ${params.input_files} --formatdb_path ${params.formatdb_exec} --protein ${params.protein} --database_name ${params.output_directory}/${params.database_name}
    """
}

workflow {
    // Serial execution chain
    formatdb()
}
