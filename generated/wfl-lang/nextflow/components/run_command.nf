#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: run_command
// Generated from Ergatis component JSON by EELS

params {
    input_args = ''
    input_command = ''
}

process run_command {
    script:
    """
    ${params.input_command} ${params.input_args} \
        1>${params.command_stdout} \
        2>{{COMMAND_STDERR}}
    """
}

workflow {
    // Serial execution chain
    run_command()
}
