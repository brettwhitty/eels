#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bsml_qc
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    check_dup_polypeptide = ''
    check_partial = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
    use_pathema_asmbl_id = ''
}

process bsml_qc {
    script:
    """
    ${params.bin_dir}/bsml_qc --input_file ${params.i_file_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --check_dup_polypeptide ${params.check_dup_polypeptide} --check_partial ${params.check_partial} --use_pathema_asmbl_id ${params.use_pathema_asmbl_id} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    bsml_qc()
}
