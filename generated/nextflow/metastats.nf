#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: metastats
// Generated from Ergatis component JSON by EELS

params {
    bootstraps = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    metastats_path = ''
    output_directory = ''
}

process Metastats_statistical_comparison {
    script:
    """
    ${params.metastats_path} -m ${params.i_file_path} -b ${params.bootstraps} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    Metastats_statistical_comparison()
}
