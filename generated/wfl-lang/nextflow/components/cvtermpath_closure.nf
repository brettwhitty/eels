#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: cvtermpath_closure
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    cv_ids = ''
    workflow_repository = ''
}

process create_file_iterator_list {
    script:
    """
    ${params.bin_dir}/create_iterator_list --input_list ${params.cv_ids} --output_iter_list ${params.workflow_repository}/cv_id.list
    """
}

workflow {
    // Serial execution chain
    create_file_iterator_list()
}
