#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: prokpipe_consistency_checks
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database = ''
    input_file_list = ''
    output_directory = ''
    password = ''
    server = ''
    tmp_dir = ''
    username = ''
}

process prokpipe_consistency_checks {
    script:
    """
    ${params.bin_dir}/prokpipe_consistency_checks --input_list ${params.input_file_list} --output_dir ${params.output_directory} --database ${params.database} --host ${params.server} --user ${params.username} --pass ${params.password} --log ${params.tmp_dir}/error_detector.log --debug 4
    """
}

workflow {
    // Serial execution chain
    prokpipe_consistency_checks()
}
