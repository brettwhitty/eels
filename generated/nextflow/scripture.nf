#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: scripture
// Generated from Ergatis component JSON by EELS

params {
    alignment = ''
    bin_dir = ''
    chrm_sequence_dir = ''
    chrm_size_file = ''
    min_splice_support_reads = ''
    other_scripture_options = ''
    output_directory = ''
    paired_end_file = ''
    scripture_exec = ''
    tmp_dir = ''
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

process Scripture_wrapper_script {
    script:
    """
    ${params.bin_dir}/scripture.sh ${params.scripture_exec} ${params.output_directory} ${params.alignment} ${params.paired_end_file} ${params.chrm_size_file} ${params.chrm_sequence_dir} ${params.min_splice_support_reads} ${params.other_scripture_options} \
        1>${params.output_directory}/scripture_stdout \
        2>{{OUTPUT_DIRECTORY}}/scripture_stderr
    """
}

workflow {
    // Serial execution chain
    Create_output_directory()
    Create_temp_directory()
    Scripture_wrapper_script()
}
