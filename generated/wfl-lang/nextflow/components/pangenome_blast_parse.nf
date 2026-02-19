#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pangenome_blast_parse
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    coverage_cutoff = ''
    db_list = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    organism_to_db_mapping = ''
    output_directory = ''
    similarity_cutoff = ''
}

process parse_blast_results {
    script:
    """
    ${params.bin_dir}/pangenome_blast_parse --input ${params.i_file_path} --coverage_cutoff ${params.coverage_cutoff} --similarity_cutoff ${params.similarity_cutoff} --output_path ${params.output_directory}/${params.iterator_name}/g${params.group_number} --db_list ${params.db_list} --organism_to_db_mapping ${params.organism_to_db_mapping} \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    parse_blast_results()
}
