#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: download_tcga
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    cghub_key = ''
    genetorrent_path = ''
    num_retries = ''
    output_directory = ''
    python_exec = ''
    rate_limit = ''
    tcga_id = ''
}

process Download_SRA_Reads {
    script:
    """
    ${params.bin_dir}/download_tcga --tcga_id ${params.tcga_id} --output_dir ${params.output_directory} --genetorrent ${params.genetorrent_path} --cghub_key ${params.cghub_key} --python_exec ${params.python_exec} --num_retry ${params.num_retries} --rate_limit ${params.rate_limit} \
        1>${params.output_directory}/download_tcga.stdout \
        2>{{OUTPUT_DIRECTORY}}/download_tcga.stderr
    """
}

workflow {
    // Serial execution chain
    Download_SRA_Reads()
}
