#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: initdb
// Generated from Ergatis component JSON by EELS

params {
    admin_pass = ''
    admin_user = ''
    bin_dir = ''
    database = ''
    debug = ''
    docs_dir = ''
    password_file = ''
    rdbms = ''
    server = ''
    tmp_dir = ''
    workflow_repository = ''
}

process check_database {
    script:
    """
    ${params.bin_dir}/checkDatabase --username ${params.admin_user} --password '${params.admin_pass}' --password_file ${params.password_file} --database ${params.database} --database_type ${params.rdbms} --assert 1 --server ${params.server} --logfile ${params.tmp_dir}/checkDatabase.pl.log \
        1>${params.tmp_dir}/checkDatabase.stdout \
        2>{{TMP_DIR}}/checkDatabase.stderr
    """
}

process Drop_chado_mart_tables_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/drop_cm_tables.${params.rdbms}.ddl --outfile ${params.tmp_dir}/drop_cm_tables.list --logfile ${params.tmp_dir}/ddl2iterator.pl.drop_cm_tables.log \
        1>${params.tmp_dir}/ddl2iterator.pl.drop_cm_tables.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.drop_cm_tables.stderr
    """
}

process Drop_chado_mart_views_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/drop_cm_views.${params.rdbms}.ddl --outfile ${params.tmp_dir}/drop_cm_views.list --logfile ${params.tmp_dir}/ddl2iterator.pl.drop_cm_views.log \
        1>${params.tmp_dir}/ddl2iterator.pl.drop_cm_views.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.drop_cm_views.stderr
    """
}

process Drop_tables_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/drop_tables.${params.rdbms}.ddl --outfile ${params.tmp_dir}/drop_tables.list --logfile ${params.tmp_dir}/ddl2iterator.pl.drop_tables.log \
        1>${params.tmp_dir}/ddl2iterator.pl.drop_tables.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.drop_tables.stderr
    """
}

process Drop_all_remaining_tables {
    script:
    """
    ${params.bin_dir}/dropChadoObjects --username ${params.admin_user} --password '${params.admin_pass}' --password_file ${params.password_file} --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --logfile ${params.tmp_dir}/dropChadoObjects.pl.log \
        1>${params.tmp_dir}/dropChadoObjects.stdout \
        2>{{TMP_DIR}}/dropChadoObjects.stderr
    """
}

process Create_tables_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/create_tables.${params.rdbms}.ddl --outfile ${params.tmp_dir}/create_tables.list --logfile ${params.tmp_dir}/ddl2iterator.pl.create_tables.log \
        1>${params.tmp_dir}/ddl2iterator.pl.create_tables.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.create_tables.stderr
    """
}

process Create_chado_mart_views_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/create_cm_views.${params.rdbms}.ddl --outfile ${params.tmp_dir}/create_cm_views.list --logfile ${params.tmp_dir}/ddl2iterator.pl.create_cm_views.log \
        1>${params.tmp_dir}/ddl2iterator.pl.create_cm_views.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.create_cm_views.stderr
    """
}

process Create_chado_mart_tables_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/create_cm_tables.${params.rdbms}.ddl --outfile ${params.tmp_dir}/create_cm_tables.list --logfile ${params.tmp_dir}/ddl2iterator.pl.create_cm_tables.log \
        1>${params.tmp_dir}/ddl2iterator.pl.create_cm_tables.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.create_cm_tables.stderr
    """
}

process Partition_tables {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/partition_tables.${params.rdbms}.ddl --outfile ${params.tmp_dir}/partition_tables.list --logfile ${params.tmp_dir}/ddl2iterator.pl.partition_tables.log \
        1>${params.tmp_dir}/ddl2iterator.pl.partition_tables.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.partition_tables.stderr
    """
}

process Create_indexes_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/create_indexes.${params.rdbms}.ddl --outfile ${params.tmp_dir}/create_indexes.list --logfile ${params.tmp_dir}/ddl2iterator.pl.create_indexes.log \
        1>${params.tmp_dir}/ddl2iterator.pl.create_indexes.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.create_indexes.stderr
    """
}

process Grant_all_permissions_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/grant_all_public.${params.rdbms}.ddl --outfile ${params.tmp_dir}/grant_all_public.list --logfile ${params.tmp_dir}/ddl2iterator.pl.grant_all_public.log \
        1>${params.tmp_dir}/ddl2iterator.pl.grant_all_public.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.grant_all_public.stderr
    """
}

process Grant_all_permissions_on_all_chado_mart_tables_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/grant_permissions_cm_tables.${params.rdbms}.ddl --outfile ${params.tmp_dir}/grant_permissions_cm_tables.list --logfile ${params.tmp_dir}/ddl2iterator.pl.grant_permissions_cm_tables.log \
        1>${params.tmp_dir}/ddl2iterator.pl.grant_permissions_cm_tables.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.grant_permissions_cm_tables.stderr
    """
}

process Grant_all_permissions_on_all_chado_mart_views_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator --infile ${params.docs_dir}/ddls/${params.rdbms}/grant_permissions_cm_views.${params.rdbms}.ddl --outfile ${params.tmp_dir}/grant_permissions_cm_views.list --logfile ${params.tmp_dir}/ddl2iterator.pl.grant_permissions_cm_views.log \
        1>${params.tmp_dir}/ddl2iterator.pl.grant_permissions_cm_views.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.grant_permissions_cm_views.stderr
    """
}

process Store_chado_revision_number {
    script:
    """
    ${params.bin_dir}/store_chado_version --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.admin_user} --password '${params.admin_pass}' --password_file ${params.password_file} --debug_level ${params.debug} --bin_dir ${params.bin_dir} --workflow ${params.workflow_repository} --log4perl ${params.workflow_repository}/store_chado_version.log \
        1>${params.workflow_repository}/store_chado_version.stdout \
        2>{{WORKFLOW_REPOSITORY}}/store_chado_version.stderr
    """
}

workflow {
    // Serial execution chain
    check_database()
    Drop_chado_mart_tables_list()
    Drop_chado_mart_views_list()
    Drop_tables_list()
    Drop_all_remaining_tables()
    Create_tables_list()
    Create_chado_mart_views_list()
    Create_chado_mart_tables_list()
    Partition_tables()
    Create_indexes_list()
    Grant_all_permissions_list()
    Grant_all_permissions_on_all_chado_mart_tables_list()
    Grant_all_permissions_on_all_chado_mart_views_list()
    Store_chado_revision_number()
}
