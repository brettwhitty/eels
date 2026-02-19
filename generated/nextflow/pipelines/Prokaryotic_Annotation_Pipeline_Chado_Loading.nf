#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Prokaryotic_Annotation_Pipeline_Chado_Loading
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Prokaryotic_Annotation_Pipeline_Chado_Loading/

// Component includes
// include { ... } from './bsml2chado'
// include { ... } from './concatenate_files'
// include { ... } from './formatdb'
// include { ... } from './initdb'
// include { ... } from './pathway_tools_input'
// include { ... } from './replace_defline_with_locusID'
// include { ... } from './scp_files'

workflow {
    initdb_default()  // initdb.default
    bsml2chado_pipeline_summary()  // bsml2chado.pipeline_summary
    bsml2chado_signalp()  // bsml2chado.signalp
    bsml2chado_lipop()  // bsml2chado.lipop
    bsml2chado_ps_scan()  // bsml2chado.ps_scan
    bsml2chado_hmm_pre()  // bsml2chado.hmm_pre
    bsml2chado_hmm_post()  // bsml2chado.hmm_post
    bsml2chado_tmhmm()  // bsml2chado.tmhmm
    bsml2chado_ber_pre()  // bsml2chado.ber_pre
    bsml2chado_ber_post()  // bsml2chado.ber_post
    // --- parallel ---
    scp_files_copy_ber_pre()  // scp_files.copy_ber_pre
    scp_files_copy_ber_post()  // scp_files.copy_ber_post
    pathway_tools_input_default()  // pathway_tools_input.default
    // --- end parallel ---
    // --- parallel ---
    concatenate_files_prot()  // concatenate_files.prot
    replace_defline_with_locusID_prot()  // replace_defline_with_locusID.prot
    formatdb_prot()  // formatdb.prot
    scp_files_copy_formatdb_prot()  // scp_files.copy_formatdb_prot
    concatenate_files_nuc()  // concatenate_files.nuc
    replace_defline_with_locusID_nuc()  // replace_defline_with_locusID.nuc
    formatdb_nuc()  // formatdb.nuc
    scp_files_copy_formatdb_nuc()  // scp_files.copy_formatdb_nuc
    formatdb_genome()  // formatdb.genome
    scp_files_copy_genome()  // scp_files.copy_genome
    // --- end parallel ---
}
