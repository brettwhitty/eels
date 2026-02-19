#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bwa
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bwa_exec = ''
    cleanup = ''
    gap_extn_penalty = ''
    gap_open_penalty = ''
    group_number = ''
    index_bam = ''
    iterator_name = ''
    i_file_path_1 = ''
    i_file_path_2 = ''
    max_align = ''
    max_gap_extns = ''
    max_gap_opens = ''
    max_threads = ''
    mismatch_penalty = ''
    output_directory = ''
    samtools_exec = ''
    tmp_dir = ''
}

process BWA_Execution {
    script:
    """
    ${params.bin_dir}/bwa_wrapper --query_file ${params.i_file_path_2} --ref_file ${params.i_file_path_1} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --tmp_dir ${params.tmp_dir}/${params.iterator_name}/g${params.group_number} --mismatch ${params.mismatch_penalty} --max_gaps ${params.max_gap_opens} --max_gap_extensions ${params.max_gap_extns} --open_gap_penalty ${params.gap_open_penalty} --extend_gap_penalty ${params.gap_extn_penalty} --threads ${params.max_threads} --num_aligns ${params.max_align} --bwa_path ${params.bwa_exec} --samtools_path ${params.samtools_exec} --cleanup ${params.cleanup} --index_bam ${params.index_bam} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base_1}_v_${params.i_file_base_2}.bwa_align_exec.ref1.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE_1}}_v_{{I_FILE_BASE_2}}.bwa_align_exec.ref1.stderr
    """
}

workflow {
    // Serial execution chain
    BWA_Execution()
}
