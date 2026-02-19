#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: lgt_build_bwa_index
// Generated from Ergatis component JSON by EELS

params {
    algorithm = ''
    bin_dir = ''
    bwa_exec = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
}

process lgt_build_index {
    script:
    """
    ${params.bin_dir}/lgt_build_index --reference ${params.i_file_path} --bwa_path ${params.bwa_exec} --algo ${params.algorithm} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.build_index.stderr
    """
}

workflow {
    // Serial execution chain
    lgt_build_index()
}
