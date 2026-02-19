#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: GenBank_submission_no_annotation
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/GenBank_submission_no_annotation/

// Component includes
// include { ... } from './create_db_list_file'
// include { ... } from './dump_fasta'

workflow {
    create_db_list_file_default()  // create_db_list_file.default
    dump_fasta_default()  // dump_fasta.default
}
