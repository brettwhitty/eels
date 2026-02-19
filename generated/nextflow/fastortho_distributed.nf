#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fastortho_distributed
// Generated from Ergatis component JSON by EELS

params {
    component_name = ''
    fastortho_bin = ''
    other_args = ''
    output_directory = ''
}

process run_FastOrtho {
    script:
    """
    ${params.fastortho_bin}/FastOrtho ${params.other_args} --option_file ${params.output_directory}/${params.component_name}.config \
        1>${params.output_directory}/${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    run_FastOrtho()
}
