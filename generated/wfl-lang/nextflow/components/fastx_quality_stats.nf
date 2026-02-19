#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fastx_quality_stats
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    fastx_bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    other_args = ''
    output_directory = ''
    quality_string = ''
}

process fastx_quality_stats {
    script:
    """
    ${params.bin_dir}/fastx_quality_stats ${params.other_args} --infile ${params.i_file_path} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --quality ${params.quality_string} --fastx_bin_dir ${params.fastx_bin_dir} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/fastx_quality_stats.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/fastx_quality_stats.stderr
    """
}

workflow {
    // Serial execution chain
    fastx_quality_stats()
}
