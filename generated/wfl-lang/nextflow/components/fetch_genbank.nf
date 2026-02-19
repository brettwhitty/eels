#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fetch_genbank
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database = ''
    format = ''
    output_directory = ''
    query = ''
    tmp_dir = ''
}

process fetch_genbank {
    script:
    """
    ${params.bin_dir}/fetch_genbank --query ${params.query} --database ${params.database} --format ${params.format} --output_dir ${params.output_directory} --log ${params.tmp_dir}/fetch_genbank.log --debug 4
    """
}

workflow {
    // Serial execution chain
    fetch_genbank()
}
