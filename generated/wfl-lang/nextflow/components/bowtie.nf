#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bowtie
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bowtie_bin_dir = ''
    bowtie_index_dir = ''
    bowtie_index_prefix = ''
    file_type = ''
    group_number = ''
    input_file_1 = ''
    input_file_2 = ''
    iterator_name = ''
    library_type = ''
    max_insert = ''
    max_multihits = ''
    min_insert = ''
    mode = ''
    num_hits = ''
    num_mismatches = ''
    num_threads = ''
    other_args = ''
    other_parameters = ''
    output_directory = ''
    report_multihits = ''
    samtools_bin_dir = ''
    seed_length = ''
    unmapped_reads = ''
}

process bowtie {
    script:
    """
    ${params.bin_dir}/bowtie ${params.other_args} --seq1file ${params.input_file_1} --seq2file '${params.input_file_2}' --bowtie_index_dir ${params.bowtie_index_dir} --prefix ${params.bowtie_index_prefix} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --bowtie_bin_dir ${params.bowtie_bin_dir} --samtools_bin_dir ${params.samtools_bin_dir} --mode ${params.mode} --num_mismatches ${params.num_mismatches} --file-type ${params.file_type} --seedlen ${params.seed_length} --minins ${params.min_insert} --maxins ${params.max_insert} --library-type ${params.library_type} --k ${params.num_hits} --m '${params.max_multihits}' --M '${params.report_multihits}' --un '${params.unmapped_reads}' --threads ${params.num_threads} --args '${params.other_parameters}' \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/bowtie.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/bowtie.stderr
    """
}

workflow {
    // Serial execution chain
    bowtie()
}
