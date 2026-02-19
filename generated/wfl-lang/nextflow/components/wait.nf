#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: wait
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    time = ''
}

process wait {
    script:
    """
    ${params.bin_dir}/spin_wait --time ${params.time} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    wait()
}
