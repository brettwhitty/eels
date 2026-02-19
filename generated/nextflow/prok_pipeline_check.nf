#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: prok_pipeline_check
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    check_pipelineid = ''
    check_repository_root = ''
    log = ''
}

process prok_pipeline_check {
    script:
    """
    ${params.bin_dir}/prok_pipeline_check --pipeline_id ${params.check_pipelineid} --repository_root ${params.check_repository_root} --log "${params.log}" --include_transcript_level $;INCLUDE_TRANSCRIPT_LEVEL
    """
}

workflow {
    // Serial execution chain
    prok_pipeline_check()
}
