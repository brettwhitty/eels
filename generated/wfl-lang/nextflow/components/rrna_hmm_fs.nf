#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: rrna_hmm_fs
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    evalue = ''
    group_number = ''
    hmm_db = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    other_opts = ''
    output_directory = ''
}

process rRNA_hmm_fs {
    script:
    """
    ${params.bin_dir}/rrna_hmm_fs --input ${params.i_file_path} --LibHmm ${params.hmm_db} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.out --Evalue ${params.evalue} ${params.other_opts} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

process check_env_variables {
    script:
    """
    env \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/env.out \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/env.err
    """
}

workflow {
    // Serial execution chain
    rRNA_hmm_fs()
    check_env_variables()
}
