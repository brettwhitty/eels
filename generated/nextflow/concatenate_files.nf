#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: concatenate_files
// Generated from Ergatis component JSON by EELS

params {
    input_file_list = ''
    output_file = ''
}

process concatenate_files {
    script:
    """
    for i in `cat ${params.input_file_list}`; do cat $i; done >> ${params.output_file}
    """
}

workflow {
    // Serial execution chain
    concatenate_files()
}
