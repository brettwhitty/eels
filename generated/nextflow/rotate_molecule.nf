#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: rotate_molecule
// Generated from Ergatis component JSON by EELS

params {
    assembly = ''
    bin_dir = ''
    coord = ''
    database = ''
    password = ''
    server = ''
    tmp_dir = ''
    username = ''
}

process rotate_molecule {
    script:
    """
    ${params.bin_dir}/rotate_molecule --host ${params.server} --database ${params.database} --username ${params.username} --password ${params.password} --coord ${params.coord} --asmbl ${params.assembly} --log ${params.tmp_dir}/rotate_molecule.log \
        1>${params.tmp_dir}/rotate_molecule.pl.stdout \
        2>{{TMP_DIR}}/rotate_molecule.pl.stderr
    """
}

workflow {
    // Serial execution chain
    rotate_molecule()
}
