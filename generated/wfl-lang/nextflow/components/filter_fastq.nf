#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: filter_fastq
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    output_directory = ''
    reads = ''
    read_list = ''
}

process filter_fastq {
    script:
    """
    ${params.bin_dir}/filter_fastq --fastq_input ${params.reads} --read_names ${params.read_list} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.basename}.bwa_align_exec.ref1.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{BASENAME}}.bwa_align_exec.ref1.stderr
    """
}

workflow {
    // Serial execution chain
    filter_fastq()
}
