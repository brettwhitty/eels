#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: JOCs_comparative_pipeline
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/JOCs_comparative_pipeline/

// Component includes
// include { ... } from './bsml2fasta'
// include { ... } from './j_ortholog_clusters'
// include { ... } from './jaccard'
// include { ... } from './muscle'
// include { ... } from './split_multifasta'
// include { ... } from './wu-blastp'
// include { ... } from './xdformat'

workflow {
    bsml2fasta_fastamulti()  // bsml2fasta.fastamulti
    split_multifasta_default()  // split_multifasta.default
    xdformat_default()  // xdformat.default
    wu_blastp_default()  // wu-blastp.default
    jaccard_default()  // jaccard.default
    muscle_jaccard()  // muscle.jaccard
    j_ortholog_clusters_default()  // j_ortholog_clusters.default
    muscle_j_ortholog_clusters()  // muscle.j_ortholog_clusters
}
