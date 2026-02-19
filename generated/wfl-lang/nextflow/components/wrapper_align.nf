#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: wrapper_align
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    other_args = ''
    output_directory = ''
    output_repository = ''
    pipeline_id = ''
}

process wrapper_align {
    script:
    """
    ${params.bin_dir}/wrapper_align ${params.other_args} --pipeline ${params.pipeline_id} --outrep ${params.output_repository} --outdir ${params.output_directory} \
        1>${params.output_directory}/wrapper_align.stdout \
        2>{{OUTPUT_DIRECTORY}}/wrapper_align.stderr
    """
}

workflow {
    // Serial execution chain
    wrapper_align()
}
