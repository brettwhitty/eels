#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: gff3_to_fasta
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    sequence_type = ''
    type = ''
}

process gff3_to_fasta {
    script:
    """
    ${params.bin_dir}/gff3_to_fasta --type ${params.type} --sequence_type ${params.sequence_type} --input_file ${params.i_file_path} --output_fasta ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.fasta \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    gff3_to_fasta()
}
