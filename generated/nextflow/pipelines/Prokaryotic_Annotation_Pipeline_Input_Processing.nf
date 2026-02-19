#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_Annotation_Pipeline_Input_Processing
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_Annotation_Pipeline_Input_Processing/

// Component includes
// include { ... } from './clean_fasta'
// include { ... } from './split_multifasta'

workflow {
    clean_fasta_clean_fasta()  // clean_fasta.clean_fasta
    split_multifasta_default()  // split_multifasta.default
}
