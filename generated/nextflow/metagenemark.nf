#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: metagenemark
// Generated from Ergatis component JSON by EELS

params {
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    metagenemark_exec = ''
    other_opts = ''
    output_directory = ''
    training_model = ''
}

process metagenemark {
    script:
    """
    ${params.metagenemark_exec} ${params.other_opts} -f g -m ${params.training_model} ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.metagenemark.gff
    """
}

workflow {
    // Serial execution chain
    metagenemark()
}
