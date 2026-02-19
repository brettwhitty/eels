#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: hmmer
// Generated from Ergatis component JSON by EELS

params {
    config_options = ''
    database_path = ''
    hmmls_exec = ''
    i_file_path = ''
}

process hmmls {
    script:
    """
    ${params.hmmls_exec} ${params.config_options} ${params.database_path} ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    hmmls()
}
