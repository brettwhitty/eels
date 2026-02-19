#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: alien_hunter
// Generated from Ergatis component JSON by EELS

params {
    alien_hunter_exec = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
}

process alien_hunter {
    script:
    """
    ${params.alien_hunter_exec} ${params.i_file_path} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.out -c \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout
    """
}

workflow {
    // Serial execution chain
    alien_hunter()
}
