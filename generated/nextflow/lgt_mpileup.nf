#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: lgt_mpileup
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    fasta_reference = ''
    i_file_path = ''
    output_directory = ''
    samtools_exec = ''
}

process mpileup_Execution {
    script:
    """
    ${params.bin_dir}/lgt_mpileup --samtools_path ${params.samtools_exec} --fasta_ref ${params.fasta_reference} --input_file ${params.i_file_path} --output_dir ${params.output_directory} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    mpileup_Execution()
}
