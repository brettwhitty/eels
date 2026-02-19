#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: extract_assembly_stats
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    limit = ''
    n50_base = ''
    output_directory = ''
}

process extract_assembly_stats {
    script:
    """
    ${params.bin_dir}/extract_assembly_stats --input ${params.i_file_path} --n50base ${params.n50_base} --limit ${params.limit} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stats
    """
}

workflow {
    // Serial execution chain
    extract_assembly_stats()
}
