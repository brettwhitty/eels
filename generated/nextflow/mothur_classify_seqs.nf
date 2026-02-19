#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mothur_classify_seqs
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_name = ''
    i_file_path = ''
    mothur_exec = ''
    output_directory = ''
    taxonomy = ''
    template = ''
}

process classify_seqs {
    script:
    """
    ${params.bin_dir}/mothur --mothur_exe ${params.mothur_exec} --input_file ${params.i_file_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --args "#classify.seqs(fasta=${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_name}, template=${params.template}, taxonomy=${params.taxonomy})" \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    classify_seqs()
}
