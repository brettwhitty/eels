#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: sffinfo
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
    output_types = ''
    sffinfo_exec = ''
    tmp_dir = ''
}

process sffinfo {
    script:
    """
    ${params.bin_dir}/sffinfo --sffinfo_exec ${params.sffinfo_exec} --config_opts ${params.config_params} --input ${params.i_file_path} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} --output_type ${params.output_types} --log ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.log --debug 4 \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stdout
    """
}

workflow {
    // Serial execution chain
    sffinfo()
}
