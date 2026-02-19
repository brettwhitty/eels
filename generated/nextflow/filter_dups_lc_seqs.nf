#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: filter_dups_lc_seqs
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    i_file_path = ''
    java_exec = ''
    lc_method = ''
    lc_threshold = ''
    output_directory = ''
    picard_tools = ''
    prefix = ''
    prinseq_exec = ''
    rm_duplicates = ''
    rm_low_complexity = ''
    samtools_exec = ''
    tmp_dir = ''
}

process Filter_duplicate_and_low_complexity_sequences {
    script:
    """
    ${params.bin_dir}/filter_dups_lc_seqs --samtools_path ${params.samtools_exec} --prinseq_path ${params.prinseq_exec} --picard_path ${params.picard_tools} --java_path ${params.java_exec} --input_file ${params.i_file_path} --tmp_dir ${params.tmp_dir} --rm_duplicates ${params.rm_duplicates} --rm_low_complexity ${params.rm_low_complexity} --lc_method ${params.lc_method} --lc_threshold ${params.lc_threshold} --prefix ${params.prefix} --output_dir ${params.output_directory}/ \
        1>${params.output_directory}/filter.stdout \
        2>{{OUTPUT_DIRECTORY}}/filter.stderr
    """
}

workflow {
    // Serial execution chain
    Filter_duplicate_and_low_complexity_sequences()
}
