#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: parse_for_ncRNAs
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bsml_lists = ''
    component_name = ''
    docs_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    project = ''
    project_id_repository = ''
}

process parse_for_ncRNAs {
    script:
    """
    ${params.bin_dir}/parse_for_ncRNAs --input_file ${params.i_file_path} --bsml_lists ${params.bsml_lists} --id_repository ${params.project_id_repository} --project ${params.project} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml
    """
}

process dtd_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml -d ${params.docs_dir}/bsml3_1.dtd
    """
}

workflow {
    // Serial execution chain
    parse_for_ncRNAs()
    dtd_validation()
}
