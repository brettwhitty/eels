#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: uclust
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    identity_threshold = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    sort_algorithm = ''
    tmp_dir = ''
    uclust_exec = ''
}

process sort {
    script:
    """
    cd ${params.tmp_dir}/${params.iterator_name}/g${params.group_number} ; ${params.uclust_exec} --${params.sort_algorithm} ${params.i_file_path} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.sorted \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

process cluster {
    script:
    """
    cd ${params.tmp_dir}/${params.iterator_name}/g${params.group_number} ; ${params.uclust_exec} --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.sorted --uc ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.uc --id ${params.identity_threshold} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

process convert_to_fasta {
    script:
    """
    cd ${params.tmp_dir}/${params.iterator_name}/g${params.group_number} ; ${params.uclust_exec} --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.sorted --uc2fasta ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.uc --types S --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.cluster.raw \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

process format_fasta {
    script:
    """
    cd ${params.tmp_dir}/${params.iterator_name}/g${params.group_number} ; ${params.bin_dir}/format_uclust_fasta_ids --fasta_input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.cluster.raw --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.cluster.fsa --log ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}_format.log --debug 4 \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/format_uclust_fasta_ids_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/format_uclust_fasta_ids_{{I_FILE_BASE}}.stderr
    """
}

process format_clustering_file {
    script:
    """
    cd ${params.tmp_dir}/${params.iterator_name}/g${params.group_number} ; ${params.uclust_exec} --uc2clstr ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.uc --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.clstr \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/format_uclust_clustering_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/format_uclust_clustering_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    sort()
    cluster()
    convert_to_fasta()
    format_fasta()
    format_clustering_file()
}
