#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: velvet
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    file_format = ''
    group_number = ''
    hash_length = ''
    iterator_name = ''
    i_file_base = ''
    output_directory = ''
    read_type = ''
    tmp_dir = ''
    velvetg_exec = ''
    velvetg_opts = ''
    velveth_exec = ''
    velveth_opts = ''
}

process create_velveth_temp_directory {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}/${params.i_file_base}
    """
}

process create_velvetg_temp_directory {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}/${params.i_file_base}
    """
}

process velveth {
    script:
    """
    ${params.velveth_exec} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}/${params.i_file_base} ${params.hash_length} ${params.file_format} ${params.read_type} ${params.velveth_opts} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

process velveth_post_processing {
    script:
    """
    ${params.bin_dir}/velveth_post_processing --input_dir ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}/${params.i_file_base} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --output_prefix ${params.i_file_base} --log ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}/${params.component_name}.${params.i_file_base}.log
    """
}

process velvetg_pre_processing {
    script:
    """
    ${params.bin_dir}/velvetg_pre_processing --input_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --output_dir ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}/${params.i_file_base} --prefix ${params.i_file_base} --log ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}/${params.component_name}.${params.i_file_base}.log
    """
}

process velvetg {
    script:
    """
    ${params.velvetg_exec} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}/${params.i_file_base} ${params.velvetg_opts} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

process velvetg_post_processing {
    script:
    """
    ${params.bin_dir}/velvetg_post_processing --input_dir ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}/${params.i_file_base} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --output_prefix ${params.i_file_base} --log ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}/${params.component_name}.${params.i_file_base}.log
    """
}

workflow {
    // Serial execution chain
    create_velveth_temp_directory()
    create_velvetg_temp_directory()
    velveth()
    velveth_post_processing()
    velvetg_pre_processing()
    velvetg()
    velvetg_post_processing()
}
