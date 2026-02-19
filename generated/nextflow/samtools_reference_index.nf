#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: samtools_reference_index
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    other_args = ''
    output_directory = ''
    samtools_bin_dir = ''
}

process samtools_reference_index {
    script:
    """
    ${params.bin_dir}/samtools_reference_index ${params.other_args} --reffile ${params.i_file_path} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --samtools_bin_dir ${params.samtools_bin_dir} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/samtools_reference_index.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/samtools_reference_index.stderr
    """
}

workflow {
    // Serial execution chain
    samtools_reference_index()
}
