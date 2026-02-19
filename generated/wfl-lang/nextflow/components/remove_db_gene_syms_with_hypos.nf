#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: remove_db_gene_syms_with_hypos
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    host = ''
    i_file_path = ''
    password = ''
    password_file = ''
    update = ''
    username = ''
}

process remove_hypothetical_ec {
    script:
    """
    ${params.bin_dir}/remove_hypothetical_ec --username ${params.username} --password ${params.password} --password_file ${params.password_file} --server ${params.host} --database_file ${params.i_file_path} --update ${params.update} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.ec..stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.ec.stderr
    """
}

process remove_db_gene_syms_with_hypotheticals {
    script:
    """
    ${params.bin_dir}/remove_db_gene_syms_with_hypos --username ${params.username} --password ${params.password} --password_file ${params.password_file} --server ${params.host} --database_file ${params.i_file_path} --update ${params.update} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.gene_syms.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.gene_syms.stderr
    """
}

workflow {
    // Serial execution chain
    remove_hypothetical_ec()
    remove_db_gene_syms_with_hypotheticals()
}
