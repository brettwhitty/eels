#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mugsy_concat_fasta
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_bsml_list = ''
    input_fsa_list = ''
    output_directory = ''
}

process concat_fasta {
    script:
    """
    ${params.bin_dir}/mugsy_concat_fasta --input_bsml_list ${params.input_bsml_list} --input_fasta_list ${params.input_fsa_list} --output_directory ${params.output_directory} \
        1>${params.output_directory}/${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    concat_fasta()
}
