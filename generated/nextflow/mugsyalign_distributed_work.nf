#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mugsyalign_distributed_work
// Generated from Ergatis component JSON by EELS

params {
    fasta_file_list = ''
    mugsy_exec = ''
    other_opts = ''
    output_directory = ''
    output_prefix = ''
}

process run_mugsy {
    script:
    """
    ${params.mugsy_exec} ${params.other_opts} --directory ${params.output_directory} --fasta_file_list ${params.fasta_file_list} --prefix ${params.output_prefix} \
        1>${params.output_directory}/${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    run_mugsy()
}
