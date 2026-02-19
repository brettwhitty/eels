#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: update_euk_model_sequences
// Generated from Ergatis component JSON by EELS

params {
    asmbl_id = ''
    bin_dir = ''
    database = ''
    debug = ''
    group_number = ''
    iterator_name = ''
    output_directory = ''
    password = ''
    server = ''
    tmp_dir = ''
    username = ''
}

process deriveCDSSequences {
    script:
    """
    ${params.bin_dir}/deriveCDSSequences --database ${params.database} --server ${params.server} --password ${params.password} --username ${params.username} --output_sequence_sql_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}.update-sequences.sql --current_sequence_output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}.update-sequences.current.dat --output_protein_sql_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}.update-proteins.sql --current_protein_output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}.update-proteins.current.dat --logfile ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.database}.${params.asmbl_id}.deriveCDSSequences.pl.log --debug_level ${params.debug} --asmbl_id ${params.asmbl_id} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}.deriveCDSSequences.pl.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{DATABASE}}_{{ASMBL_ID}}.deriveCDSSequences.pl.stderr
    """
}

workflow {
    // Serial execution chain
    deriveCDSSequences()
}
