#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: adjust_bsml_coordinates
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bsml_list = ''
    docs_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_name = ''
    i_file_path = ''
    map_dir = ''
    output_directory = ''
}

process adjust_bsml_coordinates {
    script:
    """
    ${params.bin_dir}/adjust_bsml_coordinates --input_file ${params.i_file_path} --list_file ${params.bsml_list} --output_dir ${params.output_directory}/i1/g${params.group_number} --map_dir ${params.map_dir} --removed_log ${params.output_directory}/i1/g${params.group_number}/${params.i_file_base}_removed.log
    """
}

process dtd_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_name} -d ${params.docs_dir}/bsml3_1.dtd
    """
}

workflow {
    // Serial execution chain
    adjust_bsml_coordinates()
    dtd_validation()
}
