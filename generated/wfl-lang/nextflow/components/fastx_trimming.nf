#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fastx_trimming
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    fastx_bin_dir = ''
    first_base = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    last_base = ''
    other_args = ''
    output_directory = ''
    quality_string = ''
}

process fastx_trimming {
    script:
    """
    ${params.bin_dir}/fastx_trimming ${params.other_args} --infile ${params.i_file_path} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --quality ${params.quality_string} --first_base '${params.first_base}' --last_base '${params.last_base}' --fastx_bin_dir ${params.fastx_bin_dir} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/fastx_trimming.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/fastx_trimming.stderr
    """
}

workflow {
    // Serial execution chain
    fastx_trimming()
}
