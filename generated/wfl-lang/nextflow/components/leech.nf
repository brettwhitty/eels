#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: leech
// Generated from Ergatis component JSON by EELS

params {
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    type = ''
    xaxis_name = ''
    yaxis_name = ''
}

process leech_plotting {
    script:
    """
    /opt/leech/leech -F ${params.i_file_path} -X ${params.xaxis_name} -Y ${params.yaxis_name} -T ${params.type} -P ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    leech_plotting()
}
