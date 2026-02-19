#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: selfsim
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    i_file_path = ''
    shift = ''
    window_size = ''
}

process selfsim {
    script:
    """
    ${params.bin_dir}/selfsim ${params.i_file_path} ${params.window_size} ${params.shift} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.txt
    """
}

workflow {
    // Serial execution chain
    selfsim()
}
