#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: move_to_scratch
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_extension = ''
    output_directory = ''
    tmp_dir = ''
}

process move_to_scratch {
    script:
    """
    ${params.bin_dir}/move_to_scratch --input_list ${params.component_extension} --output_dir ${params.output_directory} --scratch_dir ${params.tmp_dir} --log ${params.output_directory}/move_to_scratch.log --debug 4
    """
}

workflow {
    // Serial execution chain
    move_to_scratch()
}
