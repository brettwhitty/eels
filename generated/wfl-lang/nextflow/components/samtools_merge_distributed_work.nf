#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: samtools_merge_distributed_work
// Generated from Ergatis component JSON by EELS

params {
    component_name = ''
    input_file_list = ''
    output_directory = ''
    samtools_exec = ''
}

process merge_BAM_files {
    script:
    """
    ${params.samtools_exec} merge -b ${params.input_file_list} -n ${params.output_directory}/${params.component_name}.bam \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    merge_BAM_files()
}
