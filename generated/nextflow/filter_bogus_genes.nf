#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: filter_bogus_genes
// Generated from Ergatis component JSON by EELS

params {
    base = ''
    bin_dir = ''
    cutoff = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    output_token = ''
}

process filter_bogus_genes {
    script:
    """
    ${params.bin_dir}/filter_bogus_genes --input_file ${params.i_file_path} --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.output_token}.fsa --cutoff ${params.cutoff} --base ${params.base} \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{OUTPUT_TOKEN}}.stderr
    """
}

workflow {
    // Serial execution chain
    filter_bogus_genes()
}
