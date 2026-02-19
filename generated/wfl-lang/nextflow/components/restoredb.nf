#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: restoredb
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    docs_dir = ''
}

process Drop_views_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/drop_views.ddl \
        1>${params.tmp_dir}/drop_views.list
    """
}

process Drop_tables_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/drop_tables.ddl \
        1>${params.tmp_dir}/drop_tables.list
    """
}

process Create_tables_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/create_tables.ddl \
        1>${params.tmp_dir}/create_tables.list
    """
}

process Create_views_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/create_views.ddl \
        1>${params.tmp_dir}/create_views.list
    """
}

process Partition_tables {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/partition_tables.ddl \
        1>${params.tmp_dir}/partition_tables.list
    """
}

process Create_indexes_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/create_indexes.ddl \
        1>${params.tmp_dir}/create_indexes.list
    """
}

process Grant_all_permissions_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/grant_all_public.ddl \
        1>${params.tmp_dir}/grant_all_public.list
    """
}

workflow {
    // Serial execution chain
    Drop_views_list()
    Drop_tables_list()
    Create_tables_list()
    Create_views_list()
    Partition_tables()
    Create_indexes_list()
    Grant_all_permissions_list()
}
