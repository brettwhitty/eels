#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fasta2bsml
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    class = ''
    format = ''
    genus = ''
    input_file = ''
    input_file_list = ''
    output_directory = ''
    output_file = ''
    output_list = ''
    output_subdir_size = ''
    species = ''
}

process fasta2bsml {
    script:
    """
    ${params.bin_dir}/fasta2bsml --fasta_input '${params.input_file}' --fasta_list '${params.input_file_list}' --format '${params.format}' --class '${params.class}' --genus '${params.genus}' --species '${params.species}' --output '${params.output_directory}/${params.output_file}' --output_list '${params.output_list}' --output_subdir_size ${params.output_subdir_size}
    """
}

workflow {
    // Serial execution chain
    fasta2bsml()
}
