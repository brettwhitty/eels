#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: parallel_sort
// Generated from Ergatis component JSON by EELS

params {
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    split_lines = ''
    tmp_dir = ''
}

process split {
    script:
    """
    split  -d -l ${params.split_lines} ${params.i_file_path} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.split.
    """
}

workflow {
    // Serial execution chain
    split()
}
