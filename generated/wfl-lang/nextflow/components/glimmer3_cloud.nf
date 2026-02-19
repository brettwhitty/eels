#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: glimmer3_cloud
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    glimmer3_dir = ''
    icm = ''
    input_file = ''
    input_file_list = ''
    long_orfs_opts = ''
    staging_dir = ''
    tmp_dir = ''
    training_seq = ''
}

process create_staging_directory {
    script:
    """
    mkdir -p -m 777 ${params.staging_dir}
    """
}

process train_for_glimmer {
    script:
    """
    ${params.bin_dir}/train_for_glimmer3 --input_list "${params.input_file_list}" --input_file "${params.input_file}" --training_seqs "${params.training_seq}" --output_file ${params.icm} --tmp_dir ${params.tmp_dir} --long_orfs_opts "${params.long_orfs_opts}" --glimmer3_dir ${params.glimmer3_dir} \
        1>${params.output_directory}/train.glimmer3.stdout \
        2>{{OUTPUT_DIRECTORY}}/train.glimmer3.stderr
    """
}

process sync_staging_directory {
    script:
    """
    /opt/vappio-scripts/syncdata.sh --synchronous
    """
}

workflow {
    // Serial execution chain
    create_staging_directory()
    train_for_glimmer()
    sync_staging_directory()
}
