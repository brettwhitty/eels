#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: ncbi-blastp (runnable example)
// Generated from Ergatis component JSON by EELS
// This is a working Nextflow translation of the Ergatis ncbi-blastp component

params {
    // Input
    query_fasta    = null       // Input FASTA file or glob
    database_path  = null       // BLAST database path

    // BLAST parameters (defaults from Ergatis ncbi-blastp.config)
    blastall_exec  = 'blastall'
    expect         = '1e-5'
    filter         = 'T'
    matrix         = 'BLOSUM62'
    database_matches = 150
    descriptions   = 150
    other_opts     = ''

    // Output control
    outdir         = 'results'
}

process blastp {
    tag "${query.simpleName}"
    publishDir "${params.outdir}", mode: 'copy'

    input:
    path query

    output:
    path "*.raw", emit: raw
    path "*.btab", emit: btab

    script:
    def base = query.simpleName
    """
    ${params.blastall_exec} \
        -p blastp \
        -i ${query} \
        -d ${params.database_path} \
        -e ${params.expect} \
        -F '${params.filter}' \
        -b ${params.database_matches} \
        -v ${params.descriptions} \
        -M ${params.matrix} \
        ${params.other_opts} \
        > ${base}.ncbi-blastp.raw

    blast2btab \
        --input ${base}.ncbi-blastp.raw \
        --output ${base}.ncbi-blastp.btab
    """
}

workflow {
    if (!params.query_fasta || !params.database_path) {
        error "Required params: --query_fasta and --database_path"
    }

    query_ch = Channel.fromPath(params.query_fasta)
    blastp(query_ch)
}
