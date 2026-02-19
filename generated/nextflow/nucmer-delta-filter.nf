#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: nucmer-delta-filter
// Generated from Ergatis component JSON by EELS

params {
    delta_filter_exec = ''
    filter_opts = ''
    i_file_path = ''
}

process delta_filter {
    script:
    """
    ${params.delta_filter_exec} ${params.filter_opts} ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.filtered.delta \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    delta_filter()
}
