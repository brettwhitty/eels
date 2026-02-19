#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fast_tree
// Generated from Ergatis component JSON by EELS

params {
    config_options = ''
    fasttree_exec = ''
    i_file_path = ''
}

process fast_tree {
    script:
    """
    ${params.fasttree_exec} ${params.config_options} < ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_name}.tree \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    fast_tree()
}
