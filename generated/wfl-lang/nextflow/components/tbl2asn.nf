#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: tbl2asn
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    codon_table = ''
    fasta_input_list = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    organism = ''
    output_directory = ''
    project_id_repository = ''
    tbl2asn_exec = ''
}

process Create_the_tbl2asn_output_directory {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/ \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.mkdir.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.mkdir.stderr
    """
}

process Copy_files_to_working_directory {
    script:
    """
    ${params.bin_dir}/prepare_for_tbl2asn --fasta_list ${params.fasta_input_list} --tbl_file ${params.i_file_path} --output_directory ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.copy.fasta.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.copy.fasta.stderr
    """
}

process Run_tbl2asn {
    script:
    """
    ${params.tbl2asn_exec} -p ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} -V bv -j "[gcode=${params.codon_table}]" -n "${params.organism}" \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.tbl2asn.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.tbl2asn.stderr
    """
}

process Fix_locus_name {
    script:
    """
    perl -pi -e 's/(LOCUS\s+${params.i_file_base})\s*(\S+.*)/$1  $2/;' ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}.gbf \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fixgbf.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.fixgbf.stderr
    """
}

process Fix_GenBank {
    script:
    """
    ${params.bin_dir}/fix_gbk --input_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}.gbf --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}.gbf.tmp --id_repository ${params.project_id_repository} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fixgbf.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.fixgbf.stderr
    """
}

process Move_GenBank {
    script:
    """
    /bin/mv  ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}.gbf.tmp ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/${params.i_file_base}.gbf
    """
}

workflow {
    // Serial execution chain
    Create_the_tbl2asn_output_directory()
    Copy_files_to_working_directory()
    Run_tbl2asn()
    Fix_locus_name()
    Fix_GenBank()
    Move_GenBank()
}
