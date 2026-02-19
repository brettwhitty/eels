#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_Annotation_Pipeline_SPAdes_Assembly
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_Annotation_Pipeline_SPAdes_Assembly/

// Component includes
// include { ... } from './SPAdes'

workflow {
    SPAdes_assembly()  // SPAdes.assembly
}
