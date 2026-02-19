#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: cuffcompare
// Generated from Ergatis component JSON by EELS

params {
    annotation_file = ''
    bin_dir = ''
    cufflinks_bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    other_args = ''
    other_params = ''
    output_directory = ''
    prefix = ''
}

process cuffcompare {
    script:
    """
    ${params.bin_dir}/cuffcompare ${params.other_args} --gtffile ${params.i_file_path} --annotation '${params.annotation_file}' --prefix ${params.prefix} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --cufflinks_bin_dir ${params.cufflinks_bin_dir} --args '${params.other_params}' \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/cuffcompare.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/cuffcompare.stderr
    """
}

workflow {
    // Serial execution chain
    cuffcompare()
}
