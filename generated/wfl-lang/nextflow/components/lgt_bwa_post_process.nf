#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: lgt_bwa_post_process
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    donor_file = ''
    donor_file_list = ''
    output_directory = ''
    recipient_file = ''
    recipient_file_list = ''
    samtools_exec = ''
}

process Post_Process_bwa_filtered_reads {
    script:
    """
    ${params.bin_dir}/lgt_bwa_post_process --samtools_path ${params.samtools_exec} --donor_file_list ${params.donor_file_list} --donor_file ${params.donor_file} --recipient_file_list ${params.recipient_file_list} --recipient_file ${params.recipient_file} --prefix post_process --output_dir ${params.output_directory}/ \
        1>${params.output_directory}/post_process.stdout \
        2>{{OUTPUT_DIRECTORY}}/post_process.stderr
    """
}

workflow {
    // Serial execution chain
    Post_Process_bwa_filtered_reads()
}
