#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: train_for_glimmer3_iteration
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    elph_bin = ''
    glimmer3_dir = ''
    glimmer3_output_token = ''
    input_fasta_list = ''
    input_predict_list = ''
    output_pwm = ''
    pipelineid = ''
    repository_root = ''
    tmp_dir = ''
}

process train_for_glimmer3_iteration {
    script:
    """
    ${params.bin_dir}/train_for_glimmer3_iteration --input_predict_list ${params.input_predict_list} --input_fasta_list ${params.input_fasta_list} --output_pwm ${params.output_pwm} --tmp_dir ${params.tmp_dir} --glimmer3_dir ${params.glimmer3_dir} --elph_bin ${params.elph_bin} --conf_ini_file ${params.repository_root}/workflow/runtime/glimmer3/${params.pipelineid}_${params.glimmer3_output_token}/glimmer3.${params.glimmer3_output_token}.user.config
    """
}

workflow {
    // Serial execution chain
    train_for_glimmer3_iteration()
}
