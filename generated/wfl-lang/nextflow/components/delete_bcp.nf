#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: delete_bcp
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    docs_dir = ''
}

process Drop_tables_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/drop_indexes.ddl --foreign_keys_only 1 \
        1>${params.tmp_dir}/drop_foreign_key_constraints.list
    """
}

process Drop_tables_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/drop_indexes.ddl --exclude_primary_keys 1 \
        1>${params.tmp_dir}/drop_non_primary_key_indices.list
    """
}

process Drop_primary_key_indices {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/drop_indexes.ddl --primary_key_indices_only 1 \
        1>${params.tmp_dir}/drop_primary_key_indices.list
    """
}

process Create_indices_and_foreign_key_constraints_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/create_indexes.ddl \
        1>${params.tmp_dir}/create_indices.list
    """
}

workflow {
    // Serial execution chain
    Drop_tables_list()
    Drop_tables_list()
    Drop_primary_key_indices()
    Create_indices_and_foreign_key_constraints_list()
}
