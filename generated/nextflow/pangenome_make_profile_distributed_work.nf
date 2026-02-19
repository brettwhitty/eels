#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pangenome_make_profile_distributed_work
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    blast_stored_file = ''
    db_filter_list = ''
    output_directory = ''
}

process make_profile {
    script:
    """
    ${params.bin_dir}/pangenome_make_profile --blast_stored_file ${params.blast_stored_file} --output_path ${params.output_directory} --db_list ${params.db_filter_list}
    """
}

workflow {
    // Serial execution chain
    make_profile()
}
