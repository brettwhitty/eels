#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: LGT_Seek_Pipeline_BWA_Index
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/LGT_Seek_Pipeline_BWA_Index/

// Component includes
// include { ... } from './lgt_build_bwa_index'

workflow {
    // --- parallel ---
    lgt_build_bwa_index_recipient()  // lgt_build_bwa_index.recipient
    lgt_build_bwa_index_donor()  // lgt_build_bwa_index.donor
    lgt_build_bwa_index_refseq()  // lgt_build_bwa_index.refseq
    // --- end parallel ---
}
