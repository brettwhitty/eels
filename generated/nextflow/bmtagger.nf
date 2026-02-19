#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bmtagger
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bmtagger_exec = ''
    group_number = ''
    input_class = ''
    input_format = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    reference_bitmask = ''
    reference_srprism = ''
    tmp_dir = ''
}

process bmtagger {
    script:
    """
    ${params.bin_dir}/run_bmtagger HASH(0x648b60fa3a48) --bmtagger_path ${params.bmtagger_exec} --input_files_path ${params.i_file_path} --reference_bitmask ${params.reference_bitmask} --reference_srprism ${params.reference_srprism} --input_format ${params.input_format} --input_class ${params.input_class} --tmp_dir ${params.tmp_dir}/${params.iterator_name}/g${params.group_number} --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    bmtagger()
}
