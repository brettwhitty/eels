#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: profile_bsml
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    tmp_dir = ''
}

process Create_the_temp_output_directories {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/
    """
}

process Create_the_output_directories {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/ \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.mkdir.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.mkdir.stderr
    """
}

process Profile_BSML_file {
    script:
    """
    ${params.bin_dir}/profileBSMLFile --infile ${params.i_file_path} --logfile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.profileBSMLFile.pl.log \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.profileBSMLFile.pl.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.profileBSMLFile.pl.stderr
    """
}

workflow {
    // Serial execution chain
    Create_the_temp_output_directories()
    Create_the_output_directories()
    Profile_BSML_file()
}
