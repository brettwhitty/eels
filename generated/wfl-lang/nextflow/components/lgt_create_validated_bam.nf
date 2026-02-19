#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: lgt_create_validated_bam
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    lgt_hits = ''
    output_directory = ''
    samtools_exec = ''
}

process Create_validated_BAM {
    script:
    """
    ${params.bin_dir}/lgt_create_validated_bam --hits_list ${params.lgt_hits} --prefix final --input_file ${params.i_file_path} --samtools_path ${params.samtools_exec} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.validated_bam.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.validated_bam.stderr
    """
}

workflow {
    // Serial execution chain
    Create_validated_BAM()
}
