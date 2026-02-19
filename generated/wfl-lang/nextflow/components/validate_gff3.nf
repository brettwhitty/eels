#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: validate_gff3
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    i_file_path = ''
}

process Validation_of_GFF3_file {
    script:
    """
    ${params.bin_dir}/gff3Valid ${params.i_file_path} \
        1>${params.tmp_dir}/gff3Valid.pl.${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/gff3Valid.pl.{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    Validation_of_GFF3_file()
}
