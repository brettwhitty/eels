#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: stap_classifier
// Generated from Ergatis component JSON by EELS

params {
    domain = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
    second_tree_step_up = ''
    stap_classifier_exec = ''
    unclassified_neighbors = ''
}

process rRNA_pipeline_for_one_pl {
    script:
    """
    ${params.stap_classifier_exec} -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number} -n ${params.unclassified_neighbors} -t ${params.second_tree_step_up} -d ${params.domain} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    rRNA_pipeline_for_one_pl()
}
