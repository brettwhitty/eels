#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: blast_seq_screen
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    blast_file_list = ''
    fasta_output = ''
    input_file_list = ''
    other_opts = ''
    output_directory = ''
}

process preprocess_input_data {
    script:
    """
    ${params.bin_dir}/get_blast_querynames.pl -f ${params.blast_file_list} -o ${params.output_directory}/screenedqueries.list
    """
}

process screen_out_queries_with_blast_hits {
    script:
    """
    ${params.bin_dir}/screen_seqs_by_ids.pl -f ${params.input_file_list} -s ${params.output_directory}/screenedqueries.list -o ${params.fasta_output} ${params.other_opts}
    """
}

workflow {
    // Serial execution chain
    preprocess_input_data()
    screen_out_queries_with_blast_hits()
}
