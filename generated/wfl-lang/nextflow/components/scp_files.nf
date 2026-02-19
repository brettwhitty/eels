#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: scp_files
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    copy_ber_flag = ''
    file_extension_filters = ''
    inputdir = ''
    outdir = ''
    output_host = ''
    tmp_dir = ''
}

process scp_files {
    script:
    """
    ${params.bin_dir}/scp_files --input_directory ${params.inputdir} --output_directory ${params.outdir} --output_host '${params.output_host}' --tmp_dir ${params.tmp_dir} --file_extension_filters '${params.file_extension_filters}' --flag '${params.copy_ber_flag}'
    """
}

workflow {
    // Serial execution chain
    scp_files()
}
