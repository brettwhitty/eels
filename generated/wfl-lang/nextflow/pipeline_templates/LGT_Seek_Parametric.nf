#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: LGT_Seek_Parametric
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/LGT_Seek_Parametric/

// Component includes
// include { ... } from './alien_hunter'
// include { ... } from './selfsim'
// include { ... } from './sighunt'

workflow {
    // --- parallel ---
    selfsim_default()  // selfsim.default
    sighunt_default()  // sighunt.default
    alien_hunter_default()  // alien_hunter.default
    // --- end parallel ---
}
