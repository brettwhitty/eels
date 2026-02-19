#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pangenome_merge_results_distributed_work
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_file = ''
    output_directory = ''
}

process merge_pangenome_data {
    script:
    """
    ${params.bin_dir}/pangenome_merge_results --input_list ${params.input_file} --output_path ${params.output_directory} \
        1>${params.output_directory}/merge.stdout \
        2>{{OUTPUT_DIRECTORY}}/merge.stderr
    """
}

workflow {
    // Serial execution chain
    merge_pangenome_data()
}
