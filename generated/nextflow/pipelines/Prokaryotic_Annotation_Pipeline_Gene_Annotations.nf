#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_Annotation_Pipeline_Gene_Annotations
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_Annotation_Pipeline_Gene_Annotations/

// Component includes
// include { ... } from './RAPSearch2'
// include { ... } from './ber'
// include { ... } from './bsml2fasta'
// include { ... } from './bsml2featurerelationships'
// include { ... } from './bsml2interevidence_fasta'
// include { ... } from './filter_bogus_genes'
// include { ... } from './formatdb'
// include { ... } from './hmmpfam3'
// include { ... } from './lipop'
// include { ... } from './ncbi-blastp'
// include { ... } from './overlap_analysis'
// include { ... } from './p_func'
// include { ... } from './parse_evidence'
// include { ... } from './pipeline_summary'
// include { ... } from './prokpipe_consistency_checks'
// include { ... } from './ps_scan'
// include { ... } from './signalp'
// include { ... } from './split_multifasta'
// include { ... } from './start_site_curation'
// include { ... } from './tmhmm'
// include { ... } from './translate_sequence'

workflow {
    translate_sequence_translate()  // translate_sequence.translate
    filter_bogus_genes_filtered()  // filter_bogus_genes.filtered
    bsml2fasta_create_blastx_pre_input()  // bsml2fasta.create_blastx_pre_input
    // --- parallel ---
    hmmpfam3_pre_overlap_analysis()  // hmmpfam3.pre_overlap_analysis
    // --- parallel ---
    RAPSearch2_pre_overlap_analysis()  // RAPSearch2.pre_overlap_analysis
    bsml2fasta_pre_overlap_analysis()  // bsml2fasta.pre_overlap_analysis
    formatdb_pre_overlap_analysis()  // formatdb.pre_overlap_analysis
    bsml2featurerelationships_pre_overlap_analysis()  // bsml2featurerelationships.pre_overlap_analysis
    // --- end parallel ---
    ber_pre_overlap_analysis()  // ber.pre_overlap_analysis
    // --- end parallel ---
    overlap_analysis_default()  // overlap_analysis.default
    start_site_curation_default()  // start_site_curation.default
    translate_sequence_translate_new_models()  // translate_sequence.translate_new_models
    bsml2fasta_create_blastx_post_input()  // bsml2fasta.create_blastx_post_input
    // --- parallel ---
    hmmpfam3_post_overlap_analysis()  // hmmpfam3.post_overlap_analysis
    // --- parallel ---
    RAPSearch2_post_overlap_analysis()  // RAPSearch2.post_overlap_analysis
    bsml2fasta_post_overlap_analysis()  // bsml2fasta.post_overlap_analysis
    formatdb_post_overlap_analysis()  // formatdb.post_overlap_analysis
    bsml2featurerelationships_post_overlap_analysis()  // bsml2featurerelationships.post_overlap_analysis
    // --- end parallel ---
    ber_post_overlap_analysis()  // ber.post_overlap_analysis
    // --- end parallel ---
    // --- parallel ---
    bsml2interevidence_fasta_default()  // bsml2interevidence_fasta.default
    split_multifasta_split_interevidence()  // split_multifasta.split_interevidence
    RAPSearch2_interevidence_search()  // RAPSearch2.interevidence_search
    translate_sequence_final_polypeptides()  // translate_sequence.final_polypeptides
    bsml2fasta_final_cds()  // bsml2fasta.final_cds
    // --- end parallel ---
    // --- parallel ---
    signalp_default()  // signalp.default
    ps_scan_default()  // ps_scan.default
    // --- end parallel ---
    // --- parallel ---
    ncbi_blastp_COGS()  // ncbi-blastp.COGS
    ncbi_blastp_eggNOG()  // ncbi-blastp.eggNOG
    // --- end parallel ---
    // --- parallel ---
    lipop_default()  // lipop.default
    tmhmm_default()  // tmhmm.default
    // --- end parallel ---
    // --- parallel ---
    parse_evidence_hmmpfam3_pre()  // parse_evidence.hmmpfam3_pre
    parse_evidence_hmmpfam3_post()  // parse_evidence.hmmpfam3_post
    parse_evidence_ber_pre()  // parse_evidence.ber_pre
    parse_evidence_ber_post()  // parse_evidence.ber_post
    parse_evidence_tmhmm()  // parse_evidence.tmhmm
    parse_evidence_eggNOG()  // parse_evidence.eggNOG
    parse_evidence_lipoprotein()  // parse_evidence.lipoprotein
    parse_evidence_hypothetical()  // parse_evidence.hypothetical
    // --- end parallel ---
    p_func_default()  // p_func.default
    pipeline_summary_default()  // pipeline_summary.default
    prokpipe_consistency_checks_bsml()  // prokpipe_consistency_checks.bsml
}
