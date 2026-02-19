#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: cuffdiff_filter
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    filters_val = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    other_parameters = ''
    output_directory = ''
    project_name = ''
}

process cuffdiff_filter {
    script:
    """
    ${params.bin_dir}/cuffdiff_filter --cuff_list ${params.i_file_path} --filters ${params.filters_val} --project_name ${params.project_name} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --args ${params.other_parameters} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/cuffdiff_filter.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/cuffdiff_filter.stderr
    """
}

workflow {
    // Serial execution chain
    cuffdiff_filter()
}
