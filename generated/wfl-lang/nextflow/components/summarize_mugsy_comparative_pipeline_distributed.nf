#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: summarize_mugsy_comparative_pipeline_distributed
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    mugsycog_raw = ''
    mugsymap = ''
    output_directory = ''
    snps = ''
}

process summarize_mugsy_comparative_pipeline {
    script:
    """
    ${params.bin_dir}/summarize_mugsy_comparative_pipeline --mugsy_map_file ${params.mugsymap} --mugsycog_raw_file ${params.mugsycog_raw} --mugsy_snps_file ${params.snps} --output_dir ${params.output_directory}
    """
}

workflow {
    // Serial execution chain
    summarize_mugsy_comparative_pipeline()
}
