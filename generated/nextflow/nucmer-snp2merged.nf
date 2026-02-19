#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: nucmer-snp2merged
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
}

process nucmer_snp2merged {
    script:
    """
    ${params.bin_dir}/nucmer-snp2merged --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.merged.tab --input_file ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.snps \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    nucmer_snp2merged()
}
