#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: exonerate
// Generated from Ergatis component JSON by EELS

params {
    exonerate_exec = ''
    i_file_path = ''
    model = ''
    other_opts = ''
    reference = ''
}

process exonerate {
    script:
    """
    ${params.exonerate_exec} --model ${params.model} ${params.other_opts} ${params.i_file_path} ${params.reference} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw
    """
}

workflow {
    // Serial execution chain
    exonerate()
}
