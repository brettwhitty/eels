#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: stap_aligner
// Generated from Ergatis component JSON by EELS

params {
    domain = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    stap_aligner_exec = ''
}

process align_to_rRNA_profile_pl {
    script:
    """
    ${params.stap_aligner_exec} -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.aln -d ${params.domain} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    align_to_rRNA_profile_pl()
}
