#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: get_bam_coverage_dx
// Generated from Ergatis component JSON by EELS

params {
    bam_coverage_dx_exec = ''
    group_number = ''
    iterator_name = ''
    i_database_base = ''
    i_database_file = ''
    i_file_path = ''
    min_coverage = ''
    output_directory = ''
    output_prefix = ''
}

process Get_BAM_Coverage {
    script:
    """
    ${params.bam_coverage_dx_exec} --input_bam ${params.i_file_path} --reference ${params.i_database_file} --coverage ${params.min_coverage} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --name ${params.output_prefix} --suffix ${params.i_database_base} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/get_bam_coverage_dx.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/get_bam_coverage_dx.stderr
    """
}

workflow {
    // Serial execution chain
    Get_BAM_Coverage()
}
