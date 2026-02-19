#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bulk_delete_chado
// Generated from Ergatis component JSON by EELS

params {
    algorithm = ''
    analysis_id = ''
    bin_dir = ''
    database = ''
    database_type = ''
    docs_dir = ''
    feature_id = ''
    is_obsolete = ''
    organism_id = ''
    output_directory = ''
    server = ''
}

process check_whether_the_workflow_should_be_executed {
    script:
    """
    ${params.bin_dir}/checkAndDelete --analysis_id ${params.analysis_id} --algorithm ${params.algorithm} --database ${params.database} --database_type ${params.database_type} --feature_id ${params.feature_id} --is_obsolete ${params.is_obsolete} --organism_id ${params.organism_id} --username chado_admin --password chado_admin99 --server ${params.server} --logfile ${params.output_directory}/checkAndDelete.pl.log \
        1>${params.output_directory}/checkAndDelete.pl.stdout \
        2>{{OUTPUT_DIRECTORY}}/checkAndDelete.pl.stderr
    """
}

process Revoke_permissions {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/ddls/${params.database_type}/revoke_all_public.${params.database_type}.ddl \
        1>${params.tmp_dir}/revoke_permissions.list \
        2>{{TMP_DIR}}/revoke_permissions.stderr
    """
}

process create_counts_directory {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/counts
    """
}

process create_table_count_SQL_files {
    script:
    """
    ${params.bin_dir}/createSelectRecordCountsSQL --database ${params.database} --database_type ${params.database_type} --analysis_id ${params.analysis_id} --algorithm ${params.algorithm} --feature_id ${params.feature_id} --is_obsolete ${params.is_obsolete} --organism_id ${params.organism_id} --for_workflow 1 --outdir ${params.output_directory}/counts --username chado_admin --password chado_admin99 --server ${params.server} --logfile ${params.output_directory}/counts/createSelectRecordCountsSQL.pl.log \
        1>${params.output_directory}/counts/createSelectRecordCountsSQL.pl.stdout \
        2>{{OUTPUT_DIRECTORY}}/counts/createSelectRecordCountsSQL.pl.stderr
    """
}

process create_directory_for_SQL_files_for_views {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/views
    """
}

process Create_the_views {
    script:
    """
    ${params.bin_dir}/createViewsSQL --database ${params.database} --database_type ${params.database_type} --analysis_id ${params.analysis_id} --algorithm ${params.algorithm} --feature_id ${params.feature_id} --is_obsolete ${params.is_obsolete} --organism_id ${params.organism_id} --for_workflow 1 --outdir ${params.output_directory}/views --username chado_admin --password chado_admin99 --server ${params.server} --logfile ${params.output_directory}/counts/createViewsSQL.pl.log \
        1>${params.output_directory}/counts/createViewsSQL.pl.stdout \
        2>{{OUTPUT_DIRECTORY}}/counts/createViewsSQL.pl.stderr
    """
}

process Truncate_tables {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/ddls/${params.database_type}/truncate_tables.${params.database_type}.ddl \
        1>${params.tmp_dir}/truncate_tables.list \
        2>{{TMP_DIR}}/truncate_tables.stderr
    """
}

process Drop_indices_and_constraints {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/ddls/${params.database_type}/drop_indexes.${params.database_type}.ddl \
        1>${params.tmp_dir}/drop_indexes.list \
        2>{{TMP_DIR}}/drop_indexes.stderr
    """
}

process Restore_indices_and_constraints {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/ddls/${params.database_type}/create_indexes.${params.database_type}.ddl \
        1>${params.tmp_dir}/create_indexes.list \
        2>{{TMP_DIR}}/create_indexes.stderr
    """
}

process Verify_counts {
    script:
    """
    ${params.bin_dir}/checkDeletedTableRecordCounts --analysis_id ${params.analysis_id} --algorithm ${params.algorithm} --feature_id ${params.feature_id} --is_obsolete ${params.is_obsolete} --organism_id ${params.organism_id} --directory ${params.output_directory} --logfile ${params.output_directory}/checkDeletedTableRecordCounts.pl.log \
        1>${params.output_directory}/checkDeletedTableRecordCounts.pl.stdout \
        2>{{OUTPUT_DIRECTORY}}/checkDeletedTableRecordCounts.pl.stderr
    """
}

process Grant_permissions {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/ddls/${params.database_type}/grant_all_public.${params.database_type}.ddl \
        1>${params.tmp_dir}/grant_permissions.list \
        2>{{TMP_DIR}}/grant_permissions.stderr
    """
}

workflow {
    // Serial execution chain
    check_whether_the_workflow_should_be_executed()
    Revoke_permissions()
    create_counts_directory()
    create_table_count_SQL_files()
    create_directory_for_SQL_files_for_views()
    Create_the_views()
    Truncate_tables()
    Drop_indices_and_constraints()
    Restore_indices_and_constraints()
    Verify_counts()
    Grant_permissions()
}
