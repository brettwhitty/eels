#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bwa_align
// Generated from Ergatis component JSON by EELS

params {
    bwasw = ''
    bwa_align_exec = ''
    gap_extn_penalty = ''
    gap_open_penalty = ''
    i_file_path = ''
    max_align = ''
    max_gap_extns = ''
    max_gap_opens = ''
    max_threads = ''
    mismatch_penalty = ''
    output_directory = ''
}

process BWA_Execution {
    script:
    """
    sh ${params.bwa_align_exec} "${params.i_file_path}" /usr/local/bin ${params.output_directory} ${params.mismatch_penalty} ${params.max_gap_opens} ${params.max_gap_extns} ${params.gap_open_penalty} ${params.gap_extn_penalty} ${params.max_threads} ${params.bwasw} ${params.max_align} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/bwa_exec.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/bwa_exec.stderr
    """
}

workflow {
    // Serial execution chain
    BWA_Execution()
}
