#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bsml2fasta
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bp_extension = ''
    class_filter = ''
    coords = ''
    format = ''
    header_class = ''
    input_file = ''
    input_file_list = ''
    output_directory = ''
    output_file = ''
    output_list = ''
    output_subdir_size = ''
    output_suffix = ''
    parse_element = ''
    role_exclude = ''
    role_include = ''
    seqs_per_fasta = ''
    split_multifasta = ''
    use_feature_ids_in_fasta = ''
    use_sequence_ids_in_fasta = ''
}

process bsml2fasta {
    script:
    """
    ${params.bin_dir}/bsml2fasta --bsml_input '${params.input_file}' --bsml_list '${params.input_file_list}' --class_filter '${params.class_filter}' --header_class '${params.header_class}' --format '${params.format}' --split_multifasta '${params.split_multifasta}' --seqs_per_fasta '${params.seqs_per_fasta}' --output '${params.output_directory}/${params.output_file}' --output_list '${params.output_list}' --parse_element '${params.parse_element}' --output_subdir_size ${params.output_subdir_size} --role_exclude '${params.role_exclude}' --role_include '${params.role_include}' --bp_extension '${params.bp_extension}' --use_feature_ids_in_fasta '${params.use_feature_ids_in_fasta}' --use_sequence_ids_in_fasta '${params.use_sequence_ids_in_fasta}' --coords ${params.coords} --suffix '${params.output_suffix}'
    """
}

process Fix_fasta__nucleotide_only_ {
    script:
    """
    ${params.bin_dir}/fix_nuc_fasta --output_list '${params.output_list}' --class_filter '${params.class_filter}'
    """
}

workflow {
    // Serial execution chain
    bsml2fasta()
    Fix_fasta__nucleotide_only_()
}
