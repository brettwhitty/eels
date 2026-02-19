#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pangenome_make_table_distributed_work
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    comparisons = ''
    input_file = ''
    multiplicity = ''
    output_directory = ''
}

process make_table {
    script:
    """
    ${params.bin_dir}/pangenome_make_table --profile ${params.input_file} --output_dir ${params.output_directory} --multiplicity ${params.multiplicity} --comparisons ${params.comparisons} \
        1>${params.output_directory}/${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    make_table()
}
