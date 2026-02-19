#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: genbank2bsml
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    generate_new_seq_ids = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    organism_to_prefix_mapping = ''
    output_directory = ''
    project = ''
    project_id_repository = ''
    skip_incomplete_feature_groups = ''
    skip_unknown_dbxref = ''
    translate_empty_cds = ''
    unique_feature_tags = ''
}

process genbank2bsml {
    script:
    """
    ${params.bin_dir}/genbank2bsml --organism_to_prefix_mapping ${params.organism_to_prefix_mapping} --unique_feature_tags ${params.unique_feature_tags} --generate_new_seq_ids ${params.generate_new_seq_ids} --translate_empty_cds ${params.translate_empty_cds} --input_file ${params.i_file_path} --output_bsml ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --id_repository ${params.project_id_repository} --project ${params.project} --skip_unknown_dbxref ${params.skip_unknown_dbxref} --skip_incomplete_feature_groups ${params.skip_incomplete_feature_groups} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    genbank2bsml()
}
