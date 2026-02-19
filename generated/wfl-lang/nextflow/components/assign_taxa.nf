#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: assign_taxa
// Generated from Ergatis component JSON by EELS

params {
    assigned_taxa_file = ''
    bin_dir = ''
    filtered_subjects_file = ''
    input_file_list = ''
}

process filter_subjects_based_on_alignment_length {
    script:
    """
    ${params.bin_dir}/filter_subjects_based_on_align_score --input_file_list ${params.input_file_list} --output_file ${params.filtered_subjects_file}
    """
}

process assign_taxa {
    script:
    """
    ${params.bin_dir}/assign_taxa --input_file ${params.filtered_subjects_file} --taxonomy_file $(vp-describe-dataset --tag-name clovr-refseqdb | gawk ' $2 ~ /.*antn$/ { print $2; }') --output_file ${params.assigned_taxa_file} \
        2>{{TMP_DIR}}/assign_taxa.pl.{{PIPELINEID}}.stderr
    """
}

workflow {
    // Serial execution chain
    filter_subjects_based_on_alignment_length()
    assign_taxa()
}
