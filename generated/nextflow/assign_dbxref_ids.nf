#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: assign_dbxref_ids
// Generated from Ergatis component JSON by EELS

params {
    assign_missing = ''
    bin_dir = ''
    db_name = ''
    feature_type = ''
    id_prefix_map = ''
    i_file_path = ''
    molecule_type = ''
    organism_id = ''
    password = ''
    password_file = ''
    server = ''
    username = ''
    version = ''
    zero_pad = ''
}

process assign_dbxref_IDs {
    script:
    """
    ${params.bin_dir}/assign_dbxref_ids --input_map_file ${params.i_file_path} --user ${params.username} --password ${params.password} --password_file ${params.password_file} --server ${params.server} --db_name ${params.db_name} --id_prefix_map ${params.id_prefix_map} --feat_type ${params.feature_type} --organism_id ${params.organism_id} --assign_missing ${params.assign_missing} --version ${params.version} --zero_pad ${params.zero_pad} --molecule_type ${params.molecule_type} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    assign_dbxref_IDs()
}
