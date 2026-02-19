#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_Annotation_Pipeline_IPD
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_Annotation_Pipeline_IPD/

// Component includes
// include { ... } from './complete_study_stage'

workflow {
    complete_study_stage_default()  // complete_study_stage.default
}
