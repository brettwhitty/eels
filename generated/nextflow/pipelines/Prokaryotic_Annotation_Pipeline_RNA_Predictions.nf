#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_Annotation_Pipeline_RNA_Predictions
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_Annotation_Pipeline_RNA_Predictions/

// Component includes
// include { ... } from './infernal'
// include { ... } from './tRNAscan-SE'

workflow {
    infernal_default()  // infernal.default
    tRNAscan_SE_find_tRNA()  // tRNAscan-SE.find_tRNA
}
