#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: download_sra
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    fetch_metadata = ''
    ftp_path = ''
    num_retries = ''
    output_directory = ''
    password = ''
    run_id = ''
    username = ''
}

process Download_SRA_Reads {
    script:
    """
    ${params.bin_dir}/download_sra --run_id ${params.run_id} --output_dir ${params.output_directory} --ftp ${params.ftp_path} --username ${params.username} --password ${params.password} --num_retry ${params.num_retries} --fetch_metadata ${params.fetch_metadata} \
        1>${params.output_directory}/download_sra.stdout \
        2>{{OUTPUT_DIRECTORY}}/download_sra.stderr
    """
}

workflow {
    // Serial execution chain
    Download_SRA_Reads()
}
