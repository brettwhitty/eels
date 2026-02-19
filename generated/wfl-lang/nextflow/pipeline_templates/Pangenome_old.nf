#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Pangenome_old
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Pangenome_old/

// Component includes
// include { ... } from './pangenome'  // TODO: component .nf not found
// include { ... } from './split_multifasta'
// include { ... } from './wu-blastp'
// include { ... } from './wu-tblastn'
// include { ... } from './xdformat'

workflow {
    xdformat_default()  // xdformat.default
    xdformat_pepdb()  // xdformat.pepdb
    split_multifasta_default()  // split_multifasta.default
    wu_blastp_default()  // wu-blastp.default
    wu_tblastn_default()  // wu-tblastn.default
    pangenome_default()  // pangenome.default
}
