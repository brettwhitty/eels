#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mothur_get_oturep
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    distance_file = ''
    dist_format = ''
    fasta_file = ''
    group_file = ''
    group_number = ''
    iterator_name = ''
    i_file_name = ''
    i_file_path = ''
    label = ''
    mothur_exec = ''
    name_file = ''
    output_directory = ''
}

process get_oturep {
    script:
    """
    ${params.bin_dir}/mothur --mothur_exe ${params.mothur_exec} --input_file ${params.i_file_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --args "#get.oturep(${params.dist_format}=${params.distance_file}, name=${params.name_file}, list=${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_name}, fasta=${params.fasta_file}, group=${params.group_file}, label=${params.label})" \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    get_oturep()
}
