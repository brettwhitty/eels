#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: create_amoscmp_input
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_file = ''
    output_directory = ''
    sff_file = ''
}

process run_create_amoscmp_input {
    script:
    """
    ${params.bin_dir}/create_amoscmp_input --input ${params.input_file} --sff_file ${params.sff_file} --output_directory ${params.output_directory}
    """
}

workflow {
    // Serial execution chain
    run_create_amoscmp_input()
}
