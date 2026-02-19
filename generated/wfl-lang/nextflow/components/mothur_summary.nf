#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mothur_summary
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    config_options = ''
    group_number = ''
    iterator_name = ''
    i_file_name = ''
    i_file_path = ''
    mothur_exec = ''
    otu_format = ''
    output_directory = ''
    summary_type = ''
}

process align_seqs {
    script:
    """
    ${params.bin_dir}/mothur --mothur_exe ${params.mothur_exec} --input_file ${params.i_file_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --args "#read.otu(${params.otu_format}=${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_name}); summary.${params.summary_type}(${params.config_options})" \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    align_seqs()
}
