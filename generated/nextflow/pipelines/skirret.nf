#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: skirret
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/skirret/

// Component includes
// include { ... } from './genbank2fasta'
// include { ... } from './nucmer'
// include { ... } from './nucmer-delta-filter'
// include { ... } from './nucmer-show-snps'
// include { ... } from './nucmer-snp2merged'
// include { ... } from './snp-add-gene-info'

workflow {
    genbank2fasta_reference()  // genbank2fasta.reference
    nucmer_default()  // nucmer.default
    nucmer_delta_filter_default()  // nucmer-delta-filter.default
    nucmer_show_snps_default()  // nucmer-show-snps.default
    snp_add_gene_info_default()  // snp-add-gene-info.default
    nucmer_snp2merged_default()  // nucmer-snp2merged.default
}
