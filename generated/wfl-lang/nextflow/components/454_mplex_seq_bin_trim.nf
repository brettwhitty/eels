#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: 454_mplex_seq_bin_trim
// Generated from Ergatis component JSON by EELS

params {
    barcode_file = ''
    bin_dir = ''
    forward_primer = ''
    input_file = ''
    max_barcode_offset = ''
    max_edit_dist = ''
    min_length = ''
    output_directory = ''
    reverse_primer = ''
    tmp_dir = ''
    trim = ''
}

process bin_and_trim_barcoded_sequences {
    script:
    """
    ${params.bin_dir}/bin_and_trim_barcoded_seqs --input_file ${params.input_file} --barcode_file ${params.barcode_file} --reverse_primer ${params.reverse_primer} --forward_primer ${params.forward_primer} --output_dir ${params.output_directory} --min_length ${params.min_length} --max_edit_dist ${params.max_edit_dist} --max_barcode_offset ${params.max_barcode_offset} --trim ${params.trim} --log ${params.tmp_dir}/bin_and_trim_barcoded_seqs.log \
        1>${params.tmp_dir}/bin_and_trim_barcoded_seqs.stdout \
        2>{{TMP_DIR}}/bin_and_trim_barcoded_seqs.stderr
    """
}

process summarize_check_output {
    script:
    """
    ${params.bin_dir}/count_barcoded_seqs --input_file ${params.input_file} --barcode_file ${params.barcode_file} --input_dir ${params.output_directory} --output_file ${params.output_directory}/summary.txt --log ${params.tmp_dir}/count_barcoded_seqs.log \
        1>${params.tmp_dir}/count_barcoded_seqs.stdout \
        2>{{TMP_DIR}}/count_barcoded_seqs.stderr
    """
}

workflow {
    // Serial execution chain
    bin_and_trim_barcoded_sequences()
    summarize_check_output()
}
