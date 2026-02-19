#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: rdp_classifier
// Generated from Ergatis component JSON by EELS

params {
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    java_exec = ''
    java_mx = ''
    output_directory = ''
    property_file = ''
    rdp_classifier_jar_file = ''
}

process RDP_classifier {
    script:
    """
    ${params.java_exec} -Xmx${params.java_mx} -jar ${params.rdp_classifier_jar_file} ${params.i_file_path} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.results ${params.property_file} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    RDP_classifier()
}
