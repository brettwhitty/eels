#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: summarize_mugsy_comparative_pipeline
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    genbank_list = ''
    mugsycog_raw = ''
    phylomark_fasta = ''
    summary_report = ''
}

process create_summary_report {
    script:
    """
    ${params.bin_dir}/create_comparative_summary_report --input_gbk_list ${params.genbank_list} --phylomark_fasta ${params.phylomark_fasta} --mugsycog_raw ${params.mugsycog_raw} --summary_report ${params.summary_report} \
        1>${params.output_directory}/${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    create_summary_report()
}
