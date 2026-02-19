#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: complete_study_stage
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    config = ''
    study_stage_id = ''
    tmp_dir = ''
}

process complete_study_stage {
    script:
    """
    ${params.bin_dir}/complete_study_stage --study_stage_id ${params.study_stage_id} --config ${params.config} --log ${params.tmp_dir}/complete_study_stage.log --debug 4
    """
}

workflow {
    // Serial execution chain
    complete_study_stage()
}
