#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: xdformat
// Generated from Ergatis component JSON by EELS

params {
    database_name = ''
    input_files = ''
    other_opts = ''
    output_directory = ''
    precision = ''
    seq_type = ''
    xdformat_exec = ''
}

process xdformat {
    script:
    """
    ${params.xdformat_exec} -${params.seq_type} ${params.other_opts} -o ${params.output_directory}/${params.database_name} -O${params.precision} ${params.input_files}
    """
}

workflow {
    // Serial execution chain
    xdformat()
}
