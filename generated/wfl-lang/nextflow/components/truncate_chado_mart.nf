#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: truncate_chado_mart
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database_type = ''
    docs_dir = ''
}

process Truncate_chado_mart_tables_list {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.docs_dir}/ddls/${params.database_type}/truncate_cm_tables.${params.database_type}.ddl \
        1>${params.tmp_dir}/truncate.list
    """
}

workflow {
    // Serial execution chain
    Truncate_chado_mart_tables_list()
}
