#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: start_site_curation_distributed
// Generated from Ergatis component JSON by EELS

params {
    ber_evidence = ''
    ber_extension = ''
    bin_dir = ''
    bsml_input_file = ''
    bsml_input_list = ''
    characterized_db = ''
    characterized_vote_bonus = ''
    component_name = ''
    db_password = ''
    db_username = ''
    hmm_coding_db = ''
    min_vote_cutoff = ''
    output_directory = ''
    percent_identity_cutoff = ''
    p_value_cutoff = ''
    rbs_ag_percent_cutoff = ''
    rbs_sliding_window_size = ''
}

process start_site_curation {
    script:
    """
    ${params.bin_dir}/start_site_curation --input_file "${params.bsml_input_file}" --input_list "${params.bsml_input_list}" --output_directory ${params.output_directory} --evidence ${params.ber_evidence} --ber_extension ${params.ber_extension} --char_db '${params.characterized_db}' --hmm_coding_db ${params.hmm_coding_db} --username '${params.db_username}' --password '${params.db_password}' --percent_identity_cutoff ${params.percent_identity_cutoff} --p_value_cutoff ${params.p_value_cutoff} --characterized_vote_bonus ${params.characterized_vote_bonus} --min_vote_cutoff ${params.min_vote_cutoff} --rbs_sliding_window_size ${params.rbs_sliding_window_size} --rbs_ag_percent_cutoff ${params.rbs_ag_percent_cutoff} --log ${params.output_directory}/${params.component_name}.log --debug 5
    """
}

workflow {
    // Serial execution chain
    start_site_curation()
}
