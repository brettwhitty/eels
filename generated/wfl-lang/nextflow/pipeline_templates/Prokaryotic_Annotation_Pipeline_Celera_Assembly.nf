#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_Annotation_Pipeline_Celera_Assembly
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_Annotation_Pipeline_Celera_Assembly/

// Component includes
// include { ... } from './celera-assembler'
// include { ... } from './sff_to_CA'

workflow {
    sff_to_CA_default()  // sff_to_CA.default
    celera_assembler_assembly()  // celera-assembler.assembly
}
