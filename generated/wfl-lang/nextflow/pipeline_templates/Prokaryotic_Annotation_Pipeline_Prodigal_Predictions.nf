#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_Annotation_Pipeline_Prodigal_Predictions
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_Annotation_Pipeline_Prodigal_Predictions/

// Component includes
// include { ... } from './bsml2fasta'
// include { ... } from './prodigal'
// include { ... } from './promote_gene_prediction'
// include { ... } from './translate_sequence'

workflow {
    prodigal_default()  // prodigal.default
    // --- parallel ---
    translate_sequence_translate_prediction()  // translate_sequence.translate_prediction
    bsml2fasta_prediction_CDS()  // bsml2fasta.prediction_CDS
    // --- end parallel ---
    promote_gene_prediction_promote_prediction()  // promote_gene_prediction.promote_prediction
}
