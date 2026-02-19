#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: backupdb
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    large_tables_list = ''
    table_list = ''
    tmp_dir = ''
}

process Create_table_list_for_local_backup_process {
    script:
    """
    ${params.bin_dir}/create_table_iterator_list --table_list ${params.table_list} --output_iter_list ${params.tmp_dir}/chado_table.list \
        1>${params.tmp_dir}/create_table_iterator_list.pl.stdout \
        2>{{TMP_DIR}}/create_table_iterator_list.pl.stderr
    """
}

process Create_large_table_list_for_local_backup_process {
    script:
    """
    ${params.bin_dir}/create_table_iterator_list --table_list ${params.large_tables_list} --output_iter_list ${params.tmp_dir}/large_chado_table.list \
        1>${params.tmp_dir}/create_table_iterator_list.pl.large.stdout \
        2>{{TMP_DIR}}/create_table_iterator_list.pl.large.stderr
    """
}

workflow {
    // Serial execution chain
    Create_table_list_for_local_backup_process()
    Create_large_table_list_for_local_backup_process()
}
