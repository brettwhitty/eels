#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: sam2bam
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_sam_file = ''
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

process sam2bam {
    script:
    """
    ${params.bin_dir}/sam2bam ${params.other_args} --samtools-exec ${params.samtools_path} --view_options ${params.view_options} --sort_options ${params.sort_options} --input_file ${params.input_sam_file} --output_directory ${params.output_directory} \
        1>${params.output_directory}/sam2bam.stdout \
        2>{{OUTPUT_DIRECTORY}}/sam2bam.stderr
    """
}

workflow {
    // Serial execution chain
    Create_output_directory()
    Create_temp_directory()
    sam2bam()
}
