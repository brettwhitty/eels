#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pangenome_make_pangenome_distributed_work
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    comparisons = ''
    input_file = ''
    multiplicity = ''
    output_directory = ''
    python_exec = ''
}

process make_pangenome {
    script:
    """
    ${params.bin_dir}/pangenome_make_pangenome.sh --profile ${params.input_file} --output_path ${params.output_directory} --multiplicity ${params.multiplicity} --comparisons ${params.comparisons} --python_exec ${params.python_exec} --script_bin ${params.bin_dir}
    """
}

workflow {
    // Serial execution chain
    make_pangenome()
}
