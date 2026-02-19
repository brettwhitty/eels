#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: genewise
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    i_file_path = ''
    min_chain_score = ''
    min_percent_align_chain = ''
    num_tiers = ''
    padding_length = ''
    project = ''
    work_dir = ''
}

process prepare_for_genewise {
    script:
    """
    ${params.bin_dir}/prepare_for_genewise_best_loc --bsml_file ${params.i_file_path} --project ${params.project} --work_dir ${params.work_dir} --PADDING_LENGTH ${params.padding_length} --MIN_CHAIN_SCORE ${params.min_chain_score} --num_tiers ${params.num_tiers} --MIN_PERCENT_CHAIN_ALIGN ${params.min_percent_align_chain} \
        1>${params.tmp_dir}/prepare_for_genewise_best_loc.${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/prepare_for_genewise_best_loc.{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    prepare_for_genewise()
}
