#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: clovr_metagenomics_tables
// Generated from Ergatis component JSON by EELS

params {
    annotation_file = ''
    bin_dir = ''
    blast_list = ''
    bsml_metagene_list = ''
    cluster_list = ''
    fasta_file = ''
    mapping_file = ''
    output_prefix = ''
    polypeptide_cluster_list = ''
}

process create_summary_tables {
    script:
    """
    ${params.bin_dir}/clovr_metagenomics_tsvtables.pl -b ${params.blast_list} -c ${params.cluster_list} -m `cat ${params.mapping_file}` -a ${params.annotation_file} -f ${params.fasta_file} -y ${params.bsml_metagene_list} -z ${params.polypeptide_cluster_list} -p ${params.output_prefix}
    """
}

workflow {
    // Serial execution chain
    create_summary_tables()
}
