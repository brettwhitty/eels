#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: skiff
// Generated from Ergatis component JSON by EELS

params {
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    skiff_path = ''
}

process skiff_clustering {
    script:
    """
    ${params.skiff_path} -F ${params.i_file_path} -P ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    skiff_clustering()
}
