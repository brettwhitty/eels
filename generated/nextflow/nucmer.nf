#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: nucmer
// Generated from Ergatis component JSON by EELS

params {
    config_options = ''
    coords_exec = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    nucmer_exec = ''
    output_directory = ''
    reference_genome = ''
    tmp_dir = ''
    unique_base = ''
}

process create_group_temp_folder {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}
    """
}

process create_group_output_folder {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/${params.iterator_name}/g${params.group_number}
    """
}

process nucmer {
    script:
    """
    ${params.nucmer_exec} ${params.config_options} -p ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.unique_base} ${params.reference_genome} ${params.i_file_path} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

process create_coordinates_file {
    script:
    """
    ${params.coords_exec} -T ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.unique_base}.delta > ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.unique_base}.coords
    """
}

workflow {
    // Serial execution chain
    create_group_temp_folder()
    create_group_output_folder()
    nucmer()
    create_coordinates_file()
}
