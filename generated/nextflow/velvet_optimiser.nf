#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: velvet_optimiser
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    contig_output_list = ''
    end_hash_length = ''
    long = ''
    long_paired = ''
    other_optimiser_opts = ''
    output_directory = ''
    short = ''
    short_paired = ''
    start_hash_length = ''
    velvet_path = ''
}

process run_velvet_optimiser {
    script:
    """
    ${params.bin_dir}/run_velvet_optimiser --shortPaired "${params.short_paired}" --short "${params.short}" --longPaired "${params.long_paired}" --long "${params.long}" --output_directory ${params.output_directory} --log ${params.output_directory}/run_velvet_optimser.log --velvet_path ${params.velvet_path} --start_hash_length ${params.start_hash_length} --end_hash_length ${params.end_hash_length} --other_optimiser_opts '${params.other_optimiser_opts}' --output_list ${params.contig_output_list} \
        1>${params.output_directory}/${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    run_velvet_optimiser()
}
