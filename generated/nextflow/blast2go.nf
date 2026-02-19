#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: blast2go
// Generated from Ergatis component JSON by EELS

params {
    blast2go_install = ''
    component_name = ''
    config_file = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
}

process blast2go {
    script:
    """
    java -Xms256m -Xmx1024m -jar ${params.blast2go_install}/blast2go.jar -in ${params.i_file_path} -out ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name} -prop ${params.config_file} -a
    """
}

workflow {
    // Serial execution chain
    blast2go()
}
