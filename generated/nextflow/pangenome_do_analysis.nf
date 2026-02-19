#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pangenome_do_analysis
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
}

process parse_blast_results {
    script:
    """
    ${params.bin_dir}/pangenome_blast_parse --input ${params.i_file_path} --output_path ${params.output_directory}/${params.iterator_name}/g${params.group_number}
    """
}

workflow {
    // Serial execution chain
    parse_blast_results()
}
