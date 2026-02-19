#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: uchime
// Generated from Ergatis component JSON by EELS

params {
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    mindivergence = ''
    minh = ''
    output_directory = ''
    template_file = ''
    uchime_exec = ''
}

process uchime_chimera_checker {
    script:
    """
    ${params.uchime_exec}  --input ${params.i_file_path} --db ${params.template_file} --uchimeout ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.uchime --minh ${params.minh} --mindiv ${params.mindivergence} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    uchime_chimera_checker()
}
