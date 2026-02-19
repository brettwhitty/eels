#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Pipeline: Pangenome
// Generated from Ergatis pipeline template by EELS
// Source: ergatis-install/templates/pipelines/Pangenome/

// Component includes
// include { ... } from './blastp_plus'
// include { ... } from './bsml2fasta'
// include { ... } from './create_map_file'
// include { ... } from './formatdb'
// include { ... } from './genbank2bsml'
// include { ... } from './mugsyprep'
// include { ... } from './pangenome_blast_parse'
// include { ... } from './pangenome_fix_headers'
// include { ... } from './pangenome_make_graphs'
// include { ... } from './pangenome_make_pangenome'
// include { ... } from './pangenome_make_profile'
// include { ... } from './pangenome_make_table'
// include { ... } from './pangenome_merge_results'
// include { ... } from './tblastn_plus'
// include { ... } from './translate_sequence'

workflow {
    create_map_file_default()  // create_map_file.default
    genbank2bsml_default()  // genbank2bsml.default
    // --- parallel ---
    bsml2fasta_assembly()  // bsml2fasta.assembly
    mugsyprep_assembly()  // mugsyprep.assembly
    pangenome_fix_headers_nuc()  // pangenome_fix_headers.nuc
    translate_sequence_polypeptide()  // translate_sequence.polypeptide
    mugsyprep_polypeptide()  // mugsyprep.polypeptide
    pangenome_fix_headers_prot()  // pangenome_fix_headers.prot
    // --- end parallel ---
    // --- parallel ---
    formatdb_nuc()  // formatdb.nuc
    tblastn_plus_default()  // tblastn_plus.default
    formatdb_prot()  // formatdb.prot
    blastp_plus_default()  // blastp_plus.default
    // --- end parallel ---
    pangenome_blast_parse_default()  // pangenome_blast_parse.default
    pangenome_merge_results_default()  // pangenome_merge_results.default
    pangenome_make_profile_default()  // pangenome_make_profile.default
    // --- parallel ---
    pangenome_make_table_default()  // pangenome_make_table.default
    pangenome_make_graphs_new_genes()  // pangenome_make_graphs.new_genes
    pangenome_make_graphs_core_genes()  // pangenome_make_graphs.core_genes
    pangenome_make_pangenome_default()  // pangenome_make_pangenome.default
    pangenome_make_graphs_pangenome()  // pangenome_make_graphs.pangenome
    // --- end parallel ---
}
