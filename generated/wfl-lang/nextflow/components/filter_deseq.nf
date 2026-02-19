#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: filter_deseq
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    filters_val = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    mapfile_path = ''
    other_parameters = ''
    output_directory = ''
    project_name = ''
}

process filter_deseq {
    script:
    """
    ${params.bin_dir}/filter_deseq --deseq_list ${params.i_file_path} --filters ${params.filters_val} --project_name ${params.project_name} --map_file ${params.mapfile_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --args ${params.other_parameters} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/filter_deseq.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/filter_deseq.stderr
    """
}

workflow {
    // Serial execution chain
    filter_deseq()
}
