#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: usearch
// Generated from Ergatis component JSON by EELS

params {
    algorithm = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    other_args = ''
    output_directory = ''
    tmp_dir = ''
    usearch_exec = ''
}

process usearch {
    script:
    """
    ${params.usearch_exec} --${params.algorithm} ${params.i_file_path} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}_out.fasta --centroids ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}_nr.fasta --uc ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.uc --blast6out ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.m8 ${params.other_args} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

process extract_stats {
    script:
    """
    tail -10 ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stderr >> ${params.output_directory}/stats.txt; \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/extract_stats_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/extract_stats_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    usearch()
    extract_stats()
}
