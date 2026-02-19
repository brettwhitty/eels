#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: LGT_Seek_Pipeline
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/LGT_Seek_Pipeline/

// Component includes
// include { ... } from './blast2lca'
// include { ... } from './blast_lgt_finder'
// include { ... } from './blastn_plus'
// include { ... } from './concatenate_files'
// include { ... } from './filter_dups_lc_seqs'
// include { ... } from './lgt_bwa'
// include { ... } from './lgt_bwa_post_process'
// include { ... } from './lgt_create_validated_bam'
// include { ... } from './lgt_mpileup'
// include { ... } from './sam2fasta'
// include { ... } from './sam2lca'
// include { ... } from './split_multifasta'

workflow {
    lgt_bwa_recipient()  // lgt_bwa.recipient
    lgt_bwa_donor()  // lgt_bwa.donor
    lgt_bwa_post_process_default()  // lgt_bwa_post_process.default
    // --- parallel ---
    filter_dups_lc_seqs_lgt()  // filter_dups_lc_seqs.lgt
    // --- parallel ---
    lgt_bwa_lgt()  // lgt_bwa.lgt
    sam2lca_lgt()  // sam2lca.lgt
    sam2fasta_fasta()  // sam2fasta.fasta
    split_multifasta_fasta()  // split_multifasta.fasta
    blastn_plus_nt()  // blastn_plus.nt
    concatenate_files_blast()  // concatenate_files.blast
    blast_lgt_finder_lgt()  // blast_lgt_finder.lgt
    blast2lca_lgt()  // blast2lca.lgt
    lgt_create_validated_bam_lgt()  // lgt_create_validated_bam.lgt
    lgt_bwa_validation()  // lgt_bwa.validation
    lgt_mpileup_lgt()  // lgt_mpileup.lgt
    // --- end parallel ---
    filter_dups_lc_seqs_mb()  // filter_dups_lc_seqs.mb
    lgt_bwa_mb()  // lgt_bwa.mb
    sam2lca_mb()  // sam2lca.mb
    // --- end parallel ---
}
