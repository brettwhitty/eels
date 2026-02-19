#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_Annotation_Pipeline_Velvet_Assembly
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_Annotation_Pipeline_Velvet_Assembly/

// Component includes
// include { ... } from './prepare_paired_ends_for_velvet'
// include { ... } from './velvet_optimiser'

workflow {
    prepare_paired_ends_for_velvet_default()  // prepare_paired_ends_for_velvet.default
    velvet_optimiser_assembly()  // velvet_optimiser.assembly
}
