#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pangenome_fix_headers
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    mapping_file = ''
    output_directory = ''
    python_exec = ''
}

process fix_headers {
    script:
    """
    ${params.bin_dir}/pangenome_fix_headers.sh --input_file ${params.i_file_path} --mapping_file ${params.mapping_file} --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fsa --python_exec ${params.python_exec} --script_bin ${params.bin_dir} \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    fix_headers()
}
