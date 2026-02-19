#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: snp-add-gene-info
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    query_fasta_list = ''
    reference_genbank = ''
}

process snp_add_gene_info {
    script:
    """
    ${params.bin_dir}/snp-add-gene-info --reference_genbank ${params.reference_genbank} --show_snps_file ${params.i_file_path} --query_fasta_list ${params.query_fasta_list} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    snp_add_gene_info()
}
