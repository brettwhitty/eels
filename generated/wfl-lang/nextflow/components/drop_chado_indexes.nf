#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: drop_chado_indexes
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    docs_dir = ''
    rdbms = ''
    tmp_dir = ''
}

process Drop_chado_mart_indices {
    script:
    """
    ${params.bin_dir}/ddl2iterator --database_type ${params.rdbms} --infile ${params.docs_dir}/ddls/${params.rdbms}/drop_cm_indices.${params.rdbms}.ddl --outfile ${params.tmp_dir}/drop_cm_indices.list --logfile ${params.tmp_dir}/ddl2iterator.pl.drop_cm_indices.log \
        1>${params.tmp_dir}/ddl2iterator.pl.drop_cm_indices.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.drop_cm_indices.stderr
    """
}

process Drop_indexes {
    script:
    """
    ${params.bin_dir}/ddl2iterator --database_type ${params.rdbms} --infile ${params.docs_dir}/ddls/${params.rdbms}/drop_indexes.${params.rdbms}.ddl --outfile ${params.tmp_dir}/drop_indexes.list --logfile ${params.tmp_dir}/ddl2iterator.pl.drop_indexes.log \
        1>${params.tmp_dir}/ddl2iterator.pl.drop_indexes.stdout \
        2>{{TMP_DIR}}/ddl2iterator.pl.drop_indexes.stderr
    """
}

workflow {
    // Serial execution chain
    Drop_chado_mart_indices()
    Drop_indexes()
}
