#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: LGT_Seek_Phylogenetic
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/LGT_Seek_Phylogenetic/

// Component includes
// include { ... } from './blastp_plus'
// include { ... } from './concatenate_files'
// include { ... } from './getorf'

workflow {
    // --- parallel ---
    getorf_assembly()  // getorf.assembly
    // --- parallel ---
    blastp_plus_sister()  // blastp_plus.sister
    concatenate_files_sister()  // concatenate_files.sister
    blastp_plus_outside()  // blastp_plus.outside
    concatenate_files_outside()  // concatenate_files.outside
    // --- end parallel ---
    // --- end parallel ---
}
