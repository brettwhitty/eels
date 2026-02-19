#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: runsql
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    sql_file = ''
}

process Drop_indexes {
    script:
    """
    ${params.bin_dir}/ddl2iterator stdin ${params.sql_file} \
        1>${params.tmp_dir}/sql.list
    """
}

workflow {
    // Serial execution chain
    Drop_indexes()
}
