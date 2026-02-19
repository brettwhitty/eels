#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_Annotation_Pipeline_Genecalls_Input
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_Annotation_Pipeline_Genecalls_Input/

// Component includes
// include { ... } from './bsml2fasta'
// include { ... } from './clean_fasta'
// include { ... } from './create_pseudomolecules'
// include { ... } from './pmarks2bsml'
// include { ... } from './promote_gene_prediction'
// include { ... } from './pseudomolecule2glimmer3'
// include { ... } from './translate_sequence'

workflow {
    clean_fasta_genecalls()  // clean_fasta.genecalls
    create_pseudomolecules_genecalls()  // create_pseudomolecules.genecalls
    pmarks2bsml_genecalls()  // pmarks2bsml.genecalls
    pseudomolecule2glimmer3_genecalls()  // pseudomolecule2glimmer3.genecalls
    // --- parallel ---
    translate_sequence_translate_prediction()  // translate_sequence.translate_prediction
    bsml2fasta_prediction_CDS()  // bsml2fasta.prediction_CDS
    // --- end parallel ---
    promote_gene_prediction_promote_prediction()  // promote_gene_prediction.promote_prediction
}
