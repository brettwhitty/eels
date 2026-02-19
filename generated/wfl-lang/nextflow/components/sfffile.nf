#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: sfffile
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    config_params = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    raw_sff = ''
    sfffile_exec = ''
    tmp_dir = ''
}

process sfffile {
    script:
    """
    ${params.bin_dir}/sfffile -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.sff -i ${params.i_file_path} ${params.raw_sff} --raw_sff_files ${params.raw_sff} --accession_list ${params.i_file_path} --sfffile_exe ${params.sfffile_exec} --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.sff --command_line_opts ${params.config_params} --log ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.log --debug 4 \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    sfffile()
}
