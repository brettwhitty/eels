#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: predict_prokaryotic_gene_function
// Generated from Ergatis component JSON by EELS

params {
    annotate_on = ''
    ber_info = ''
    ber_list = ''
    bin_dir = ''
    hmm_info = ''
    hmm_list = ''
    input_file_list = ''
    output_directory = ''
}

process predict_function {
    script:
    """
    ${params.bin_dir}/predict_prokaryotic_gene_function --input_list '${params.input_file_list}' --annotate_on '${params.annotate_on}' --hmm_list '${params.hmm_list}' --hmm_info '${params.hmm_info}' --ber_list '${params.ber_list}' --ber_info '${params.ber_info}' --output_directory '${params.output_directory}' --log '${params.output_directory}/functional_predictions.log'
    """
}

workflow {
    // Serial execution chain
    predict_function()
}
