#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: preserve_reads_in_fastq
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    seq_file = ''
}

process preserve_reads_in_fastq {
    script:
    """
    ${params.bin_dir}/preserve_reads_in_fastq ${params.i_file_path} ${params.seq_file} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/$(basename ${params.seq_file})_${params.i_file_base}.final.fastq \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    preserve_reads_in_fastq()
}
