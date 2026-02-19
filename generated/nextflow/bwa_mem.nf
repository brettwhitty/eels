#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bwa_mem
// Generated from Ergatis component JSON by EELS

params {
    bwa_exec = ''
    gap_extn_penalty = ''
    gap_open_penalty = ''
    i_file_path = ''
    i_mate_pair = ''
    i_ref_file = ''
    min_seed_length = ''
    mismatch_penalty = ''
    other_opts = ''
}

process BWA_Execution {
    script:
    """
    ${params.bwa_exec} mem ${params.i_ref_file} ${params.i_file_path} ${params.i_mate_pair} -k ${params.min_seed_length} -B ${params.mismatch_penalty} -O ${params.gap_open_penalty} -E ${params.gap_extn_penalty} ${params.other_opts} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.i_ref_base}.sam \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/bwa_exec.stderr
    """
}

workflow {
    // Serial execution chain
    BWA_Execution()
}
