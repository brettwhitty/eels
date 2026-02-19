#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: dump_table
// Generated from Ergatis component JSON by EELS

params {
    args = ''
    bin_dir = ''
    contig_id_replacement = ''
    contig_string = ''
    db_name = ''
    delete_url = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    linker_sequence = ''
    min_contig_len = ''
    other_tbl2asn_opts = ''
    output_directory = ''
    password = ''
    password_file = ''
    server = ''
    split_num = ''
    tbl2asn_path = ''
    username = ''
}

process dump_table {
    script:
    """
    ${params.bin_dir}/dump_table --username ${params.username} --password ${params.password} --server ${params.server} --database_list ${params.i_file_path} --locus_db ${params.db_name} --linker_sequence ${params.linker_sequence} --contig_string ${params.contig_string} --contig_id_replacement ${params.contig_id_replacement} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
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

process run_tbl2asn {
    script:
    """
    ${params.bin_dir}/wrap_tbl2asn --input_file ${params.i_file_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} --input_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} --utility_path ${params.tbl2asn_path} --opts ${params.other_tbl2asn_opts} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.wrap_tbl2asn.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.wrap_tbl2asn.stderr
    """
}

process copy_discrep_file {
    script:
    """
    /bin/cp ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}_discrep.txt ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}_first_discrep.txt
    """
}

process delete_overlapping_genes {
    script:
    """
    ${params.bin_dir}/deleteOverlappingGenes ${params.args} --db_mapping_file ${params.i_file_path} --user ${params.username} --password ${params.password} --password_file ${params.password_file} --server ${params.server} --delete_url ${params.delete_url} --discrep_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}_discrep.txt \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.deleteOverlappingGenes.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.deleteOverlappingGenes.stderr
    """
}

process dump_table {
    script:
    """
    ${params.bin_dir}/dump_table --username ${params.username} --password ${params.password} --server ${params.server} --database_list ${params.i_file_path} --locus_db ${params.db_name} --linker_sequence ${params.linker_sequence} --contig_string ${params.contig_string} --contig_id_replacement ${params.contig_id_replacement} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.rerun.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.rerun.stderr
    """
}

process fix_gene_symbols_in_tbl {
    script:
    """
    ${params.bin_dir}/fix_gene_symbols --input_file ${params.i_file_path} --tbl_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}.tbl --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}
    """
}

process create_agp {
    script:
    """
    ${params.bin_dir}/format_velvet_assembled_AGP --tbl_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}_gs_corrected.tbl --fsa_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}.fsa --split_param ${params.split_num} --min_contig_len ${params.min_contig_len} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}
    """
}

process remove_tbl_file {
    script:
    """
    /bin/rm ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}_gs_corrected.tbl
    """
}

process move_tbl_file {
    script:
    """
    /bin/mv ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}_gs_corrected_corrected.tbl ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}.tbl
    """
}

process move_fsa_file {
    script:
    """
    /bin/mv ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}_corrected.fsa ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}.fsa
    """
}

process move_agp_file {
    script:
    """
    /bin/mv ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}_gs_corrected.agp ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}.agp
    """
}

process rerun_tbl2asn {
    script:
    """
    ${params.bin_dir}/wrap_tbl2asn --input_file ${params.i_file_path} --input_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} --utility_path ${params.tbl2asn_path} --opts ${params.other_tbl2asn_opts} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.wrap_tbl2asn.rerun.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.wrap_tbl2asn.rerun.stderr
    """
}

workflow {
    // Serial execution chain
    dump_table()
    create_sbt_and_cmt_files()
    run_tbl2asn()
    copy_discrep_file()
    delete_overlapping_genes()
    dump_table()
    fix_gene_symbols_in_tbl()
    create_agp()
    remove_tbl_file()
    move_tbl_file()
    move_fsa_file()
    move_agp_file()
    rerun_tbl2asn()
}
