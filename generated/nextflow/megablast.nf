#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: megablast
// Generated from Ergatis component JSON by EELS

params {
    database_path = ''
    i_file_path = ''
    megablast_exec = ''
    wordsize = ''
}

process megablast {
    script:
    """
    ${params.megablast_exec} -i ${params.i_file_path} -d ${params.database_path} -W ${params.wordsize} -m8 \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw
    """
}

workflow {
    // Serial execution chain
    megablast()
}
