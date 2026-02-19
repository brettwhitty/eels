#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: delete_by_bcp
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database_type = ''
    docs_dir = ''
}

process Drop_indexes {
    script:
    """
    ${params.bin_dir}/ddl2iterator --exclude_primary_keys 1 stdin ${params.docs_dir}/ddls/${params.database_type}/drop_indexes.${params.database_type}.ddl \
        1>${params.tmp_dir}/drop_indexes.list
    """
}

process Rebuild_indexes {
    script:
    """
    ${params.bin_dir}/ddl2iterator --exclude_primary_keys 1 stdin ${params.docs_dir}/ddls/${params.database_type}/create_indexes.${params.database_type}.ddl \
        1>${params.tmp_dir}/create_indexes.list
    """
}

workflow {
    // Serial execution chain
    Drop_indexes()
    Rebuild_indexes()
}
