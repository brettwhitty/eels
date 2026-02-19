#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fastortho
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    blastplus_bin = ''
    inflation = ''
    input_file = ''
    input_file_list = ''
    max_e_value = ''
    mcl_bin = ''
    min_percent_id = ''
    min_percent_match = ''
    mixed_genomes = ''
    num_cpus = ''
    output_directory = ''
}

process write_FastOrtho_config_file {
    script:
    """
    ${params.bin_dir}/fastortho_write_config --output_dir ${params.output_directory} --max_eval ${params.max_e_value} --min_pct_id ${params.min_percent_id} --min_pct_match ${params.min_percent_match} --inflation ${params.inflation} --num_cpus ${params.num_cpus} --mixed_genomes ${params.mixed_genomes} --input_file ${params.input_file} --input_list ${params.input_file_list} --blast_bin ${params.blastplus_bin} --mcl_bin ${params.mcl_bin} \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.writeConfig.stderr
    """
}

workflow {
    // Serial execution chain
    write_FastOrtho_config_file()
}
