#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: db2fasta
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database = ''
    output_directory = ''
    password = ''
    protein_list_file = ''
    rdbms = ''
    schema = ''
    server = ''
    single = ''
    tmp_dir = ''
    username = ''
}

process create_output_directories {
    script:
    """
    mkdir -p -m 777 ${params.output_directory} ${params.tmp_dir} ${params.tmp_dir}/id_mapping
    """
}

process Generate_FASTA_files_from_database____DATABASE____on_server____SERVER___ {
    script:
    """
    ${params.bin_dir}/db2fasta --username ${params.username} --password ${params.password} --database ${params.database} --server ${params.server} --vendor ${params.rdbms} --schema ${params.schema} --single ${params.single} --infile ${params.protein_list_file} --outdir ${params.output_directory} \
        1>${params.tmp_dir}/db2fasta.pl.stdout \
        2>{{TMP_DIR}}/db2fasta.pl.stderr
    """
}

process Create_FASTA_file_list {
    script:
    """
    find ${params.output_directory} -name '*.fsa' \
        1>${params.fasta_output_list} \
        2>{{TMP_DIR}}/create_fasta_file_list.stderr
    """
}

workflow {
    // Serial execution chain
    create_output_directories()
    Generate_FASTA_files_from_database____DATABASE____on_server____SERVER___()
    Create_FASTA_file_list()
}
