#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pathway_tools_input
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database = ''
    db_host = ''
    locus_db = ''
    organism_name = ''
    output_directory = ''
    password = ''
    password_file = ''
    taxon_id = ''
    username = ''
}

process create_gbk_files {
    script:
    """
    ${params.bin_dir}/chado_aengine_dumper --database ${params.database} --user ${params.username} --password ${params.password} --password_file ${params.password_file} --output_directory ${params.output_directory} --format gbk --locus_db ${params.locus_db} --server ${params.db_host}
    """
}

process create_pathway_tools_input_files {
    script:
    """
    ${params.bin_dir}/create_ptools_input_files --gbk_dir ${params.output_directory} --organism_name '${params.organism_name}' --database ${params.database} --taxon_id ${params.taxon_id} --output_dir ${params.output_directory}
    """
}

workflow {
    // Serial execution chain
    create_gbk_files()
    create_pathway_tools_input_files()
}
