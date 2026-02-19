#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: SPAdes
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_file_list = ''
    output_directory = ''
    spades_bin = ''
}

process run_SPAdes {
    script:
    """
    ${params.bin_dir}/run_spades --input_list ${params.input_file_list} --output_dir ${params.output_directory} --spades_bin ${params.spades_bin} \
        1>${params.output_directory}/spades.stdout \
        2>{{OUTPUT_DIRECTORY}}/spades.stderr
    """
}

workflow {
    // Serial execution chain
    run_SPAdes()
}
