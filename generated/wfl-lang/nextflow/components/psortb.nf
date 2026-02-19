#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: psortb
// Generated from Ergatis component JSON by EELS

params {
    i_file_path = ''
    other_opts = ''
    psortb_exe = ''
}

process tmhmm {
    script:
    """
    ${params.psortb_exe} ${params.other_opts} ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw \
        2>{{TMP_DIR}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    tmhmm()
}
