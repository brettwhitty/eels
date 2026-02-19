#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bsml2mugsymap
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    tmp_dir = ''
}

process bsml2mugsymap {
    script:
    """
    ${params.bin_dir}/bsml2mugsymap --input ${params.i_file_path} --output_dir ${params.tmp_dir}/${params.iterator_name}/g${params.group_number} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    bsml2mugsymap()
}
