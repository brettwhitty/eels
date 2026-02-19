#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: split_multifasta
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    compress_output = ''
    files_per_directory = ''
    group_number = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    seqs_per_file = ''
    total_files = ''
}

process split_multifasta {
    script:
    """
    ${params.bin_dir}/split_multifasta --input_file ${params.i_file_path} --output_dir ${params.output_directory}/i1/g${params.group_number} --output_list ${params.output_directory}/i1/g${params.group_number}/${params.i_file_base}.${params.component_name}.list --output_file_prefix '${params.i_file_base}_' --seqs_per_file ${params.seqs_per_file} --total_files ${params.total_files} --output_subdir_size ${params.files_per_directory} --compress_output ${params.compress_output}
    """
}

workflow {
    // Serial execution chain
    split_multifasta()
}
