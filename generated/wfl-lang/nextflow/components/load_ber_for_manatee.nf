#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: load_ber_for_manatee
// Generated from Ergatis component JSON by EELS

params {
    ber_file_destination_server = ''
    ber_output_directory = ''
    bin_dir = ''
    db_host = ''
    db_name = ''
    db_password = ''
    db_username = ''
    destination_directory = ''
    input_file_list = ''
    local_directory = ''
}

process load_ber_analysis {
    script:
    """
    ${params.bin_dir}/add_blast_polypeptide_links --bsml_list ${params.input_file_list} --user ${params.db_username} --password ${params.db_password} --host ${params.db_host} --sourcename ${params.ber_output_directory} --database ${params.db_name} --analysis_name ber_analysis
    """
}

process move_files {
    script:
    """
    ${params.bin_dir}/move_ber_files_for_manatee --ber_output_directory ${params.ber_output_directory} --remote_directory ${params.destination_directory} --local_directory ${params.local_directory} --server ${params.ber_file_destination_server}
    """
}

workflow {
    // Serial execution chain
    load_ber_analysis()
    move_files()
}
