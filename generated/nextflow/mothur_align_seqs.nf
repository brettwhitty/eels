#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mothur_align_seqs
// Generated from Ergatis component JSON by EELS

params {
    align_algorithm = ''
    bin_dir = ''
    flip = ''
    gapextend_value = ''
    gapopen_value = ''
    group_number = ''
    iterator_name = ''
    i_file_name = ''
    i_file_path = ''
    ksize = ''
    match_value = ''
    mismatch_value = ''
    mothur_exec = ''
    output_directory = ''
    search_algorithm = ''
    template_file = ''
}

process align_seqs {
    script:
    """
    ${params.bin_dir}/mothur --mothur_exe ${params.mothur_exec} --input_file ${params.i_file_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --args "#align.seqs(candidate=${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_name}, template=${params.template_file}, search=${params.search_algorithm}, ksize=${params.ksize}, align=${params.align_algorithm}, match=${params.match_value}, mismatch=${params.mismatch_value}, gapopen=${params.gapopen_value}, gapextend=${params.gapextend_value}, flip=${params.flip})" \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    align_seqs()
}
