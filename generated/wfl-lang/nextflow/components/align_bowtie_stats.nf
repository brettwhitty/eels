#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: align_bowtie_stats
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    other_parameters = ''
    output_directory = ''
}

process align_bowtie_stats {
    script:
    """
    ${params.bin_dir}/align_bowtie_stats --infile ${params.i_file_path} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --args ${params.other_parameters} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/align_bowtie_stats.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/align_bowtie_stats.stderr
    """
}

workflow {
    // Serial execution chain
    align_bowtie_stats()
}
