#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bam_merge
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    input_bam_list = ''
    i_file_path = ''
    output_directory = ''
    samtools_bin = ''
}

process bam_merge {
    script:
    """
    ${params.bin_dir}/bam_merge --sBamInfoFile ${params.i_file_path} --outdir ${params.output_directory}/i1/g${params.group_number} --inBamFileList ${params.input_bam_list} --samtools_bin_dir ${params.samtools_bin} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/bam_merge.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/bam_merge.stderr
    """
}

workflow {
    // Serial execution chain
    bam_merge()
}
