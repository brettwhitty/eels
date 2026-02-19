#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: lgt_bwa
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bwa_args = ''
    bwa_exec = ''
    gap_extn_penalty = ''
    gap_open_penalty = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    keep_mm = ''
    max_align = ''
    max_gap_extns = ''
    max_gap_opens = ''
    max_threads = ''
    mismatch_penalty = ''
    output_directory = ''
    paired = ''
    query_file = ''
    samtools_exec = ''
    sam_sort_args = ''
    sam_view_args = ''
    softclip_min = ''
    tmp_dir = ''
    use_mem = ''
}

process BWA_alignment {
    script:
    """
    ${params.bin_dir}/lgt_bwa --input_file ${params.query_file} --reference ${params.i_file_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --use_mem ${params.use_mem} --misMsc ${params.mismatch_penalty} --maxGapO ${params.max_gap_opens} --maxGapE ${params.max_gap_extns} --gapOsc ${params.gap_open_penalty} --gapEsc ${params.gap_extn_penalty} --nThrds ${params.max_threads} --num_aligns ${params.max_align} --bwa_path ${params.bwa_exec} --samtools_path ${params.samtools_exec} --bwa_params ${params.bwa_args} --samtools_params ${params.sam_view_args} --bam_paired ${params.paired} --tmp_dir ${params.tmp_dir}/${params.iterator_name}/g${params.group_number} \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.bwa_align.stderr
    """
}

process Filter_reads {
    script:
    """
    ${params.bin_dir}/lgt_filter_reads --input_file HASH(0x5f394a624148) --input_list ${params.output_directory}/${params.iterator_name}/g${params.group_number}/bam.list --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --softclip_min ${params.softclip_min} --samtools_path ${params.samtools_exec} --samtools_params ${params.sam_sort_args} --keep_mm_reads ${params.keep_mm} --tmp_dir ${params.tmp_dir}/${params.iterator_name}/g${params.group_number} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bwa_filter.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.bwa_filter.stderr
    """
}

workflow {
    // Serial execution chain
    BWA_alignment()
    Filter_reads()
}
