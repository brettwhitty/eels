#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: chado2flatfile
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    coords_output_file = ''
    database = ''
    locus_id = ''
    password = ''
    pep_output_file = ''
    seq_output_file = ''
    server = ''
    username = ''
}

process chado2flatfile {
    script:
    """
    ${params.bin_dir}/chado2flatfile --host ${params.server} --database ${params.database} --username ${params.username} --password ${params.password} --pep_file ${params.pep_output_file} --seq_file ${params.seq_output_file} --coords_file ${params.coords_output_file} --locus_ids ${params.locus_id} \
        1>${params.tmp_dir}/chado2flatfile.pl.stdout \
        2>{{TMP_DIR}}/chado2flatfile.pl.stderr
    """
}

workflow {
    // Serial execution chain
    chado2flatfile()
}
