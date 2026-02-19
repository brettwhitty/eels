#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: lgt_bwa_fq
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bwasw = ''
    bwa_exec = ''
    cleanup = ''
    gap_extn_penalty = ''
    gap_open_penalty = ''
    group_number = ''
    iterator_name = ''
    i_dir = ''
    i_file_base = ''
    max_align = ''
    max_gap_extns = ''
    max_gap_opens = ''
    max_threads = ''
    mismatch_penalty = ''
    output_directory = ''
    ref_file1 = ''
    ref_file2 = ''
    ref_file_list1 = ''
    ref_file_list2 = ''
}

process BWA_Execution {
    script:
    """
    ${params.bin_dir}/lgt_bwa --input_dir ${params.i_dir} --input_base ${params.i_file_base} --ref_file_list ${params.ref_file_list1} --ref_file ${params.ref_file1} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --mistmatch ${params.mismatch_penalty} --max_gaps ${params.max_gap_opens} --max_gap_extensions ${params.max_gap_extns} --open_gap_penalty ${params.gap_open_penalty} --extend_gap_penalty ${params.gap_extn_penalty} --threads ${params.max_threads} --use_bwasw ${params.bwasw} --num_aligns ${params.max_align} --bwa_path ${params.bwa_exec} --cleanup_sai ${params.cleanup} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bwa_align_exec.ref1.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.bwa_align_exec.ref1.stderr
    """
}

process BWA_Execution {
    script:
    """
    ${params.bin_dir}/lgt_bwa --input_dir ${params.i_dir} --input_base ${params.i_file_base} --ref_file_list ${params.ref_file_list2} --ref_file ${params.ref_file2} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --mistmatch ${params.mismatch_penalty} --max_gaps ${params.max_gap_opens} --max_gap_extensions ${params.max_gap_extns} --open_gap_penalty ${params.gap_open_penalty} --extend_gap_penalty ${params.gap_extn_penalty} --threads ${params.max_threads} --use_bwasw ${params.bwasw} --num_aligns ${params.max_align} --bwa_path ${params.bwa_exec} --cleanup_sai ${params.cleanup} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bwa_align_exec.ref2.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.bwa_align_exec.ref2.stderr
    """
}

process POST_PROCESSING {
    script:
    """
    ${params.bin_dir}/lgt_bwa_post_process --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} --ref1 ${params.ref_file1} --ref2 ${params.ref_file2} --ref_list1 ${params.ref_file_list1} --ref_list2 ${params.ref_file_list2} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.postprocess_exec.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.postprocess_exec.stderr
    """
}

process ZIP_FILES {
    script:
    """
    ${params.bin_dir}/lgt_bwa_zip.sh ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.zip_files_exec.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.zip_files_exec.stderr
    """
}

process REMOVE_FASTQ_FILES {
    script:
    """
    ${params.bin_dir}/lgt_bwa_rm.sh ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.remove_fastq_exec.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.remove_fastq_exec.stderr
    """
}

workflow {
    // Serial execution chain
    BWA_Execution()
    BWA_Execution()
    POST_PROCESSING()
    ZIP_FILES()
    REMOVE_FASTQ_FILES()
}
