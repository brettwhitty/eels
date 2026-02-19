#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pangenome_do_analysis_distributed_work
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    blast_stored_file = ''
    comparisons = ''
    db_filter_list = ''
    multiplicity = ''
    output_directory = ''
    write_lists = ''
}

process make_table {
    script:
    """
    ${params.bin_dir}/pangenome_make_table --blast_stored_file ${params.blast_stored_file} --output_path ${params.output_directory} --multiplicity ${params.multiplicity} --comparisons ${params.comparisons} --write_lists ${params.write_lists} --db_list ${params.db_filter_list}
    """
}

process make_profile {
    script:
    """
    ${params.bin_dir}/pangenome_make_profile --blast_stored_file ${params.blast_stored_file} --output_path ${params.output_directory} --multiplicity ${params.multiplicity} --comparisons ${params.comparisons} --write_lists ${params.write_lists} --db_list ${params.db_filter_list}
    """
}

process make_pangenome {
    script:
    """
    ${params.bin_dir}/pangenome_make_pangenome --profile ${params.output_directory}/pangenome.profile.txt --output_path ${params.output_directory} --multiplicity ${params.multiplicity} --comparisons ${params.comparisons} --write_lists ${params.write_lists} --db_list ${params.db_filter_list}
    """
}

workflow {
    // Serial execution chain
    make_table()
    make_profile()
    make_pangenome()
}
