#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: sighunt
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    cutoff = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
    r_exec = ''
    r_script = ''
    shift = ''
    window_size = ''
}

process SigHunt {
    script:
    """
    ${params.bin_dir}/run_sighunt --input_file ${params.i_file_path} --cutoff ${params.cutoff} --window_size ${params.window_size} --shift ${params.shift} --output_path ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --r_script ${params.r_script} --r_exec_path ${params.r_exec} \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    SigHunt()
}
