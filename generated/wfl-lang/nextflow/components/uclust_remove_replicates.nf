#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: uclust_remove_replicates
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    length_difference = ''
    output_directory = ''
    prefix_length = ''
}

process uclust_replicate_removal {
    script:
    """
    ${params.bin_dir}/uclust_replicate_removal -f ${params.i_file_path} -l ${params.length_difference} -k ${params.prefix_length} -p ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    uclust_replicate_removal()
}
