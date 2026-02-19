#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: snp_verification
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/snp_verification/

// Component includes
// include { ... } from './extract_snp_regions'
// include { ... } from './formatdb'
// include { ... } from './ncbi-blastn'
// include { ... } from './snp_verify'
// include { ... } from './split_multifasta'

workflow {
    // --- parallel ---
    extract_snp_regions_default()  // extract_snp_regions.default
    formatdb_default()  // formatdb.default
    // --- end parallel ---
    split_multifasta_default()  // split_multifasta.default
    ncbi_blastn_default()  // ncbi-blastn.default
    snp_verify_default()  // snp_verify.default
}
