#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: deseq
// Generated from Ergatis component JSON by EELS

params {
    annotation_file = ''
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    list_file = ''
    other_args = ''
    output_directory = ''
    r_bin_dir = ''
    r_params = ''
    r_script = ''
}

process deseq {
    script:
    """
    ${params.bin_dir}/deseq ${params.other_args} --infile ${params.i_file_path} --listfile ${params.list_file} --annotation ${params.annotation_file} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --r_bin_dir '${params.r_bin_dir}' --r_params '${params.r_params}' --r_script ${params.r_script} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/deseq.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/deseq.stderr
    """
}

workflow {
    // Serial execution chain
    deseq()
}
