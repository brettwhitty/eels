#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: GenBank_submission_pipeline
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/GenBank_submission_pipeline/

// Component includes
// include { ... } from './assign_dbxref_ids'
// include { ... } from './create_db_list_file'
// include { ... } from './curate_common_names'
// include { ... } from './dump_table'
// include { ... } from './fix_gene_symbols'
// include { ... } from './remove_db_gene_syms_with_hypos'
// include { ... } from './update_ec_numbers'

workflow {
    create_db_list_file_default()  // create_db_list_file.default
    assign_dbxref_ids_default()  // assign_dbxref_ids.default
    curate_common_names_default()  // curate_common_names.default
    remove_db_gene_syms_with_hypos_default()  // remove_db_gene_syms_with_hypos.default
    update_ec_numbers_default()  // update_ec_numbers.default
    fix_gene_symbols_db()  // fix_gene_symbols.db
    dump_table_default()  // dump_table.default
}
