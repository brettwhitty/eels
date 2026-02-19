#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: insert_pmarks_in_scaffolds
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    format = ''
    linker_sequence = ''
    output_directory = ''
    scaffold_input = ''
    strain_name = ''
    tmp_dir = ''
}

process insert_pmarks_in_scaffolds {
    script:
    """
    ${params.bin_dir}/insert_pmarks_in_scaffolds --scaffold_input ${params.scaffold_input} --strain ${params.strain_name} --format ${params.format} --output_dir ${params.output_directory} --linker_sequence ${params.linker_sequence} --log ${params.tmp_dir}/insert_pmarks_in_scaffolds.log --debug 4
    """
}

workflow {
    // Serial execution chain
    insert_pmarks_in_scaffolds()
}
