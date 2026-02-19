#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: cummerbund
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    input_file = ''
    input_file_list = ''
    iterator_name = ''
    other_args = ''
    output_directory = ''
    r_bin_dir = ''
    r_params = ''
    r_script = ''
}

process cummerbund {
    script:
    """
    ${params.bin_dir}/cummerbund ${params.other_args} --infile ${params.input_file} --listfile '${params.input_file_list}' --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --r_bin_dir '${params.r_bin_dir}' --r_params '${params.r_params}' --r_script ${params.r_script} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/cummerbund.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/cummerbund.stderr
    """
}

workflow {
    // Serial execution chain
    cummerbund()
}
