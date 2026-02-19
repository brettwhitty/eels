#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: metagenomic_contaminant_screen
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/metagenomic_contaminant_screen/

// Component includes
// include { ... } from './bmtagger'
// include { ... } from './filter_sequences_by_id'

workflow {
    bmtagger_default()  // bmtagger.default
    filter_sequences_by_id_default()  // filter_sequences_by_id.default
}
