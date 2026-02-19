#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_Annotation_Pipeline_Pseudomolecule_Generation
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_Annotation_Pipeline_Pseudomolecule_Generation/

// Component includes
// include { ... } from './clean_fasta'
// include { ... } from './create_pseudomolecules'
// include { ... } from './pmarks2bsml'

workflow {
    clean_fasta_default()  // clean_fasta.default
    create_pseudomolecules_default()  // create_pseudomolecules.default
    pmarks2bsml_default()  // pmarks2bsml.default
}
