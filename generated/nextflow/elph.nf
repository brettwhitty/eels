#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: elph
// Generated from Ergatis component JSON by EELS

params {
    elph_exec = ''
    group_number = ''
    iterator_name = ''
    iterator_num = ''
    i_file_base = ''
    i_file_path = ''
    motif_length = ''
    other_opts = ''
    output_directory = ''
    search_multi_fasta = ''
}

process create_group_output_directory {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/${params.iterator_name}/g${params.group_number}
    """
}

process elph {
    script:
    """
    ${params.elph_exec} ${params.i_file_path} ${params.search_multi_fasta} LEN=${params.motif_length} ITERNO=${params.iterator_num} ${params.other_opts} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.motif \
        1>${params.tmp_dir}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    create_group_output_directory()
    elph()
}
