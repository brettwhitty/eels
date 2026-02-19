#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: celera2hawkeye
// Generated from Ergatis component JSON by EELS

params {
    bank_transact_exec = ''
    input_files = ''
    other_opts = ''
    output_directory = ''
    output_prefix = ''
    toamos_exec = ''
}

process toAmos {
    script:
    """
    ${params.toamos_exec} ${params.input_files} -o ${params.output_directory}/${params.output_prefix}.afg ${params.other_opts} \
        1>${params.tmp_dir}/to_amos.stdout \
        2>{{TMP_DIR}}/to_amos.stderr
    """
}

process bank_transact {
    script:
    """
    ${params.bank_transact_exec} -m ${params.output_directory}/${params.output_prefix}.afg -b ${params.output_directory}/${params.output_prefix}.bnk -c \
        1>${params.tmp_dir}/celera_to_hawkeye.bank_transact.stdout \
        2>{{TMP_DIR}}/celera_to_hawkeye.bank_transact.stderr
    """
}

process cleanup_afg_file {
    script:
    """
    rm ${params.output_directory}/${params.output_prefix}.afg
    """
}

workflow {
    // Serial execution chain
    toAmos()
    bank_transact()
    cleanup_afg_file()
}
