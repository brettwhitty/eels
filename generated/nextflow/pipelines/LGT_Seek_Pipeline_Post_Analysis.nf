#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: LGT_Seek_Pipeline_Post_Analysis
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/LGT_Seek_Pipeline_Post_Analysis/

// Component includes
// include { ... } from './gather_lgtview_files'  // TODO: component .nf not found

workflow {
    gather_lgtview_files_default()  // gather_lgtview_files.default
}
