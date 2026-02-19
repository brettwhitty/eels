#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: nucmer-show-snps
// Generated from Ergatis component JSON by EELS

params {
    i_file_path = ''
    other_opts = ''
    show_snps_exec = ''
}

process delta_filter {
    script:
    """
    ${params.show_snps_exec} ${params.other_opts} ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.snps \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    delta_filter()
}
