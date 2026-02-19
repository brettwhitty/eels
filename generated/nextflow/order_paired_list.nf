#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: order_paired_list
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_file = ''
    output_file = ''
}

process order_paired_list {
    script:
    """
    ${params.bin_dir}/order_paired_list --input_list ${params.input_file} --output_list ${params.output_file}
    """
}

workflow {
    // Serial execution chain
    order_paired_list()
}
