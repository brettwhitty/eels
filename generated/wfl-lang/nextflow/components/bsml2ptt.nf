#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bsml2ptt
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    gene_feattype = ''
    gene_field = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
    pid_feattype = ''
    pid_field = ''
}

process bsml2ptt {
    script:
    """
    ${params.bin_dir}/bsml2ptt --input ${params.i_file_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --pid_feattype ${params.pid_feattype} --pid_field ${params.pid_field} --gene_feattype ${params.gene_feattype} --gene_field ${params.gene_field} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    bsml2ptt()
}
