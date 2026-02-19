#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: sort_sam_by_name
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
}

process sort_sam_by_read_name {
    script:
    """
    ${params.bin_dir}/sort_sam_by_name.sh ${params.i_file_path} ${params.output_directory}/${params.iterator_name}/g${params.group_number} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.sort_sam_by_name.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.sort_sam_by_name.stderr
    """
}

workflow {
    // Serial execution chain
    sort_sam_by_read_name()
}
