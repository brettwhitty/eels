#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: split_fasta
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    file_numbering = ''
    fragment_length = ''
    group_number = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    overlap_length = ''
    tmp_dir = ''
}

process split_fasta {
    script:
    """
    ${params.bin_dir}/split_fasta --input_file ${params.i_file_path} --output_dir ${params.output_directory}/i1/g${params.group_number} --output_list ${params.tmp_dir}/i1/${params.i_file_base}.${params.component_name}.list --fragment_length ${params.fragment_length} --overlap_length ${params.overlap_length} --file_numbering ${params.file_numbering} --file_name_root ${params.i_file_base} --bsml_map ${params.output_directory}/${params.i_file_base}.map.bsml
    """
}

workflow {
    // Serial execution chain
    split_fasta()
}
