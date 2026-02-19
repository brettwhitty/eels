#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bam2sam
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_bam_file = ''
    other_args = ''
    output_directory = ''
    samtools_path = ''
    sort_options = ''
    tmp_dir = ''
    view_options = ''
}

process Create_output_directory {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}
    """
}

process Create_temp_directory {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}
    """
}

process bam2sam {
    script:
    """
    ${params.bin_dir}/bam2sam ${params.other_args} --samtools-exec ${params.samtools_path} --view_options ${params.view_options} --sort_options ${params.sort_options} --input_file ${params.input_bam_file} --output_directory ${params.output_directory} \
        1>${params.output_directory}/bam2sam.stdout \
        2>{{OUTPUT_DIRECTORY}}/bam2sam.stderr
    """
}

workflow {
    // Serial execution chain
    Create_output_directory()
    Create_temp_directory()
    bam2sam()
}
