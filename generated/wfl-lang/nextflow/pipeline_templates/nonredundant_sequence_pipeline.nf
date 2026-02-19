#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: nonredundant_sequence_pipeline
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/nonredundant_sequence_pipeline/

// Component includes
// include { ... } from './mummer'
// include { ... } from './mumsgraph'
// include { ... } from './split_multifasta'

workflow {
    split_multifasta_default()  // split_multifasta.default
    mummer_default()  // mummer.default
    mumsgraph_default()  // mumsgraph.default
}
