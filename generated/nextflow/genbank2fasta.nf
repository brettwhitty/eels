#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: genbank2fasta
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
}

process genbank2fasta {
    script:
    """
    ${params.bin_dir}/genbank2fasta --input_file ${params.i_file_path} --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fsa \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    genbank2fasta()
}
