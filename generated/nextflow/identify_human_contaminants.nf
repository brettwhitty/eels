#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: identify_human_contaminants
// Generated from Ergatis component JSON by EELS

params {
    algorithm = ''
    bin_dir = ''
    fasta_list = ''
    human_align = ''
    min_coverage = ''
    min_perc_id = ''
    output_directory = ''
    ref_align = ''
}

process identify_human_contaminants {
    script:
    """
    ${params.bin_dir}/identify_human_contaminants --list --human_contams ${params.human_align} --ref_geno_search ${params.ref_align} --fasta_file ${params.fasta_list} --mincov ${params.min_coverage} --minpercid ${params.min_perc_id} --output_prefix ${params.output_directory}/identify_human_contaminants --algorithm ${params.algorithm} \
        1>${params.tmp_dir}/identify_human_contaminants.pl.stdout \
        2>{{TMP_DIR}}/identify_human_contaminants.pl.stderr
    """
}

process create_singleton_fasta_file {
    script:
    """
    ${params.bin_dir}/get_seq_included --fasta_list ${params.fasta_list} --seq_id_list ${params.output_directory}/identify_human_contaminants.singleton.list --output ${params.output_directory}/identify_human_contaminants.singleton \
        1>${params.tmp_dir}/get_seq_included.pl.stdout \
        2>{{TMP_DIR}}/get_seq_included.pl.stderr
    """
}

workflow {
    // Serial execution chain
    identify_human_contaminants()
    create_singleton_fasta_file()
}
