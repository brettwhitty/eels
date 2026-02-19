#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: split_fastq
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    i_file_path = ''
    output_directory = ''
    seq_number = ''
}

process split_fastq {
    script:
    """
    ${params.bin_dir}/split_fastq --input ${params.i_file_path} --outdir ${params.output_directory}/i1/g${params.group_number} --numseq ${params.seq_number} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/split_fastq_file.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/split_fastq_file.stderr
    """
}

workflow {
    // Serial execution chain
    split_fastq()
}
