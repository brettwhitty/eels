#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bwa_index
// Generated from Ergatis component JSON by EELS

params {
    algorithm = ''
    bwa_index_exec = ''
    i_file_path = ''
}

process BWA_Execution {
    script:
    """
    sh ${params.bwa_index_exec} ${params.i_file_path} /usr/local/bin ${params.algorithm} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/bwa_exec.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/bwa_exec.stderr
    """
}

workflow {
    // Serial execution chain
    BWA_Execution()
}
