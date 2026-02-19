#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: validate_bsml
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bsml_dtd = ''
    i_file_path = ''
}

process DTD_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl -d ${params.bsml_dtd} ${params.i_file_path} \
        1>${params.tmp_dir}/dtdValid.pl.${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/dtdValid.pl.{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    DTD_validation()
}
