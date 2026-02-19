#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: split_paired_files
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_file1 = ''
    input_file2 = ''
    output_directory = ''
}

process split_paired_files {
    script:
    """
    ${params.bin_dir}/split_paired_files --input_file1 ${params.input_file1} --input_file2 ${params.input_file2} --output_dir ${params.output_directory}
    """
}

workflow {
    // Serial execution chain
    split_paired_files()
}
