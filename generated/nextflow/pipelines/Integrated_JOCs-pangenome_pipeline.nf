#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Integrated_JOCs-pangenome_pipeline
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Integrated_JOCs-pangenome_pipeline/

// Component includes
// include { ... } from './bsml2fasta'
// include { ... } from './j_ortholog_clusters'
// include { ... } from './jaccard'
// include { ... } from './muscle'
// include { ... } from './pangenome'  // TODO: component .nf not found
// include { ... } from './split_multifasta'
// include { ... } from './wu-blastp'
// include { ... } from './wu-tblastn'
// include { ... } from './xdformat'

workflow {
    bsml2fasta_fastamulti()  // bsml2fasta.fastamulti
    bsml2fasta_genomicseq()  // bsml2fasta.genomicseq
    xdformat_nuc()  // xdformat.nuc
    xdformat_default()  // xdformat.default
    split_multifasta_default()  // split_multifasta.default
    // --- parallel ---
    wu_blastp_default()  // wu-blastp.default
    jaccard_default()  // jaccard.default
    muscle_jaccard()  // muscle.jaccard
    j_ortholog_clusters_default()  // j_ortholog_clusters.default
    muscle_j_ortholog_clusters()  // muscle.j_ortholog_clusters
    wu_tblastn_default()  // wu-tblastn.default
    // --- end parallel ---
    pangenome_default()  // pangenome.default
}
