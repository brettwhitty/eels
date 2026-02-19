#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: celera-assembler-distributed
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    celera_assembler_exec = ''
    input_file = ''
    input_file_list = ''
    output_directory = ''
    output_prefix = ''
    spec_file = ''
}

process runCA {
    script:
    """
    ${params.bin_dir}/runCA_wrapper --input_list "${params.input_file_list}" --input_file "${params.input_file}" --runca_opts "-p ${params.output_prefix} -d ${params.output_directory}/${params.output_prefix} -s ${params.spec_file}" --runca_bin ${params.celera_assembler_exec} \
        1>${params.output_directory}/runCA_wrapper.stdout \
        2>{{OUTPUT_DIRECTORY}}/runCA_wrapper.stderr
    """
}

workflow {
    // Serial execution chain
    runCA()
}
