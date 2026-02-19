#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: htseq_count_reads
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    counting_feature = ''
    count_mode = ''
    group_number = ''
    gtf_file = ''
    id_attribute = ''
    is_stranded = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    min_align_qual = ''
    output_directory = ''
}

process HTSeq_counting {
    script:
    """
    ${params.bin_dir}/htseq_count_reads.sh ${params.count_mode} ${params.counting_feature} ${params.min_align_qual} ${params.id_attribute} ${params.is_stranded} ${params.gtf_file} ${params.i_file_path} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.gene.counts \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.htseq.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.htseq.stderr
    """
}

workflow {
    // Serial execution chain
    HTSeq_counting()
}
