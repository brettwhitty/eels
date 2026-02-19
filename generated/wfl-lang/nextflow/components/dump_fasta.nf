#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: dump_fasta
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    contig_id_replacement = ''
    contig_string = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    linker_sequence = ''
    min_contig_len = ''
    other_tbl2asn_opts = ''
    output_directory = ''
    password = ''
    server = ''
    split_num = ''
    tbl2asn_path = ''
    username = ''
}

process dump_fasta {
    script:
    """
    ${params.bin_dir}/dump_fasta --username ${params.username} --password ${params.password} --server ${params.server} --database_list ${params.i_file_path} --linker_sequence ${params.linker_sequence} --contig_string ${params.contig_string} --contig_id_replacement ${params.contig_id_replacement} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

process create_sbt_and_cmt_files {
    script:
    """
    ${params.bin_dir}/prepare_sbt_cmt --input_file ${params.i_file_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.prepare_sbt_cmt.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.prepare_sbt_cmt.stderr
    """
}

process create_agp {
    script:
    """
    ${params.bin_dir}/format_velvet_assembled_AGP --fsa_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}.fsa --split_param ${params.split_num} --min_contig_len ${params.min_contig_len} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}
    """
}

process run_tbl2asn {
    script:
    """
    ${params.bin_dir}/wrap_tbl2asn --input_file ${params.i_file_path} --input_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} --utility_path ${params.tbl2asn_path} --opts ${params.other_tbl2asn_opts} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.wrap_tbl2asn.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.wrap_tbl2asn.stderr
    """
}

workflow {
    // Serial execution chain
    dump_fasta()
    create_sbt_and_cmt_files()
    create_agp()
    run_tbl2asn()
}
