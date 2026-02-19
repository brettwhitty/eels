#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: validate_fasta
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    i_file_base = ''
    i_file_path = ''
    tmp_dir = ''
}

process Validation_of_FASTA_file {
    script:
    """
    ${params.bin_dir}/countHeadersWithoutSequence --fastafile ${params.i_file_path} --logfile ${params.tmp_dir}/countHeadersWithoutSequence.pl.${params.i_file_base}.log \
        1>${params.tmp_dir}/countHeadersWithoutSequence.pl.${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/countHeadersWithoutSequence.pl.{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    Validation_of_FASTA_file()
}
