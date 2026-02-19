#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: refresh_chado_mart
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    blast_analysis_id = ''
    cluster_analysis_id = ''
    database = ''
    docs_dir = ''
    password = ''
    program = ''
    rdbms = ''
    server = ''
    tmp_dir = ''
    username = ''
    use_cm_blast = ''
}

process Create_truncate_chado_mart_tables_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --outfile ${params.tmp_dir}/truncate.list --logfile ${params.tmp_dir}/ddl2iterator.pl.truncate_cm_tables.log --database_type ${params.rdbms} --infile ${params.docs_dir}/ddls/${params.rdbms}/truncate_cm_tables.${params.rdbms}.ddl \
        1>${params.tmp_dir}/ddl2iterator.pl.truncate_cm_tables.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.truncate_cm_tables.stderr
    """
}

process Generate_chado_mart_data {
    script:
    """
    ${params.bin_dir}/chadoToChadoMart --blast_analysis_id ${params.blast_analysis_id} --cluster_analysis_id ${params.cluster_analysis_id} --username ${params.username} --password '${params.password}' --database ${params.database} --database_type ${params.rdbms} --batch_size 1000 --cm_proteins 1 --outdir ${params.tmp_dir} --program ${params.program} --server ${params.server} --use_cm_blast ${params.use_cm_blast} --iteratorlist 1 --logfile ${params.tmp_dir}/chadoToChadoMart.pl.log \
        1>${params.tmp_dir}/chadoToChadoMart.pl.stdout \
        2>{{TMP_DIR}}/chadoToChadoMart.pl.stderr
    """
}

process Create_drop_chado_mart_indices_and_constraints_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --database_type ${params.rdbms} --outfile ${params.tmp_dir}/drop_indices.list --logfile ${params.tmp_dir}/ddl2iterator.pl.drop_cm_indices.log --infile ${params.docs_dir}/ddls/${params.rdbms}/drop_cm_indices.${params.rdbms}.ddl \
        1>${params.tmp_dir}/ddl2iterator.pl.drop_cm_indices.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.drop_cm_indices.stderr
    """
}

process list_bcp_files {
    script:
    """
    ${params.bin_dir}/bcpdir2iterator --bcp_directory ${params.tmp_dir} --bcp_extension out --output_iterator_list ${params.tmp_dir}/bcp.out.list
    """
}

process Create_chado_mart_indices_and_constraints_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --database_type ${params.rdbms} --outfile ${params.tmp_dir}/create_indices.list --logfile ${params.tmp_dir}/ddl2iterator.pl.create_cm_indices.log --infile ${params.docs_dir}/ddls/${params.rdbms}/create_cm_indices.${params.rdbms}.ddl \
        1>${params.tmp_dir}/ddl2iterator.pl.create_cm_indices.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.create_cm_indices.stderr
    """
}

workflow {
    // Serial execution chain
    Create_truncate_chado_mart_tables_list()
    Generate_chado_mart_data()
    Create_drop_chado_mart_indices_and_constraints_list()
    list_bcp_files()
    Create_chado_mart_indices_and_constraints_list()
}
