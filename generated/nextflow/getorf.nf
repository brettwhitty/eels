#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: getorf
// Generated from Ergatis component JSON by EELS

params {
    emboss_bin = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    min_orf_length = ''
    other_opts = ''
    output_directory = ''
    table = ''
}

process Run_EMBOSS_getorf {
    script:
    """
    ${params.emboss_bin}/getorf -sequence ${params.i_file_path} -outseq ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fsa -table ${params.table} -minsize ${params.min_orf_length} ${params.other_opts} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    Run_EMBOSS_getorf()
}
