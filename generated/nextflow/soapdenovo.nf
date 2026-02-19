#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: soapdenovo
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    i_file_path = ''
    kmer_size = ''
    other_args = ''
    output_directory = ''
    output_prefix = ''
    process = ''
    soapdenovo_bin = ''
}

process soapdenovo {
    script:
    """
    ${params.bin_dir}/soapdenovo --soapdenovo_exec ${params.soapdenovo_bin} --config_file ${params.i_file_path} --process ${params.process} --args "-o ${params.output_directory}/i1/g${params.group_number}/${params.output_prefix} -K ${params.kmer_size} ${params.other_args}"
    """
}

workflow {
    // Serial execution chain
    soapdenovo()
}
