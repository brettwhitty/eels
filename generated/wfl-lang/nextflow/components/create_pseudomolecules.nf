#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: create_pseudomolecules
// Generated from Ergatis component JSON by EELS

params {
    acsn_file = ''
    bin_dir = ''
    contig_input = ''
    coords_exec = ''
    database = ''
    format = ''
    linker_sequence = ''
    nucmer_config = ''
    nucmer_exec = ''
    output_directory = ''
    strain_name = ''
    tmp_dir = ''
}

process create_pseudomolecules {
    script:
    """
    ${params.bin_dir}/create_pseudomolecules --input_file ${params.acsn_file} --contig_input ${params.contig_input} --strain ${params.strain_name} --database ${params.database} --format ${params.format} --output_dir ${params.output_directory} --nucmer_exec ${params.nucmer_exec} --coords_exec ${params.coords_exec} --config_param '${params.nucmer_config}' --linker_sequence ${params.linker_sequence} --log ${params.tmp_dir}/create_pseudomolecules.log --debug 4
    """
}

workflow {
    // Serial execution chain
    create_pseudomolecules()
}
