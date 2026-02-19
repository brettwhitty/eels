#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: prepare_paired_ends_for_velvet
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    long_input_list = ''
    long_output_list = ''
    output_directory = ''
    short_input_list = ''
    short_output_list = ''
    velvet_path = ''
}

process prepare_paired_end_files_for_velvet {
    script:
    """
    ${params.bin_dir}/prepare_paired_ends_for_velvet --output_directory ${params.output_directory} --short_input_list "${params.short_input_list}" --short_output_list "${params.short_output_list}" --long_input_list "${params.long_input_list}" --long_output_list "${params.long_output_list}" --log ${params.output_directory}/run_velvet_optimser.log --velvet_path ${params.velvet_path}
    """
}

workflow {
    // Serial execution chain
    prepare_paired_end_files_for_velvet()
}
