#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: replace_defline_with_locusID
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_bsml_list = ''
    input_file = ''
    output_file = ''
}

process replace_defline_with_locusID {
    script:
    """
    ${params.bin_dir}/replace_defline_with_locusID --fasta ${params.input_file} --output ${params.output_file} --bsml_list ${params.input_bsml_list}
    """
}

workflow {
    // Serial execution chain
    replace_defline_with_locusID()
}
