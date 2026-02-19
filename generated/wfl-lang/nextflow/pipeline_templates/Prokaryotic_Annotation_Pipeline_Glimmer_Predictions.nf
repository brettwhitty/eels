#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_Annotation_Pipeline_Glimmer_Predictions
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_Annotation_Pipeline_Glimmer_Predictions/

// Component includes
// include { ... } from './bsml2fasta'
// include { ... } from './glimmer3'
// include { ... } from './promote_gene_prediction'
// include { ... } from './train_for_glimmer3_iteration'
// include { ... } from './translate_sequence'

workflow {
    glimmer3_iter1()  // glimmer3.iter1
    train_for_glimmer3_iteration_train_for_glimmer()  // train_for_glimmer3_iteration.train_for_glimmer
    glimmer3_iter2()  // glimmer3.iter2
    // --- parallel ---
    translate_sequence_translate_prediction()  // translate_sequence.translate_prediction
    bsml2fasta_prediction_CDS()  // bsml2fasta.prediction_CDS
    // --- end parallel ---
    promote_gene_prediction_promote_prediction()  // promote_gene_prediction.promote_prediction
}
