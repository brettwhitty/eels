#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: tophat
// Generated from Ergatis component JSON by EELS

params {
    annotation_file = ''
    bin_dir = ''
    bowtie_bin_dir = ''
    bowtie_index_dir = ''
    bowtie_index_prefix = ''
    bowtie_mode = ''
    group_number = ''
    input_file_1 = ''
    input_file_2 = ''
    iterator_name = ''
    library_type = ''
    mate_inner_dist = ''
    mate_std_dev = ''
    max_coverage_intron = ''
    max_deletion_length = ''
    max_insertion_length = ''
    max_intron_length = ''
    max_multihits = ''
    max_segment_intron = ''
    min_anchor = ''
    min_coverage_intron = ''
    min_intron_length = ''
    min_segment_intron = ''
    number_threads = ''
    other_args = ''
    other_parameters = ''
    output_directory = ''
    raw_juncs_file = ''
    read_edit_dist = ''
    read_gap_length = ''
    read_mismatches = ''
    ref_deletions_file = ''
    ref_insertions_file = ''
    samtools_bin_dir = ''
    segment_length = ''
    segment_mismatches = ''
    splice_mismatches = ''
    tophat_bin_dir = ''
    transcriptome_index_prefix = ''
}

process tophat {
    script:
    """
    ${params.bin_dir}/tophat ${params.other_args} --seq1file ${params.input_file_1} --seq2file '${params.input_file_2}' --bowtie_index_dir ${params.bowtie_index_dir} --prefix ${params.bowtie_index_prefix} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --tophat_bin_dir ${params.tophat_bin_dir} --samtools_bin_dir ${params.samtools_bin_dir} --bowtie_bin_dir ${params.bowtie_bin_dir} --mate-inner-dist ${params.mate_inner_dist} --mate-std-dev ${params.mate_std_dev} --min-anchor-length ${params.min_anchor} --splice-mismatches ${params.splice_mismatches} --min-intron-length ${params.min_intron_length} --max-intron-length ${params.max_intron_length} --max-insertion-length ${params.max_insertion_length} --max-deletion-length ${params.max_deletion_length} --num-threads ${params.number_threads} --max-multihits ${params.max_multihits} --library-type ${params.library_type} --bowtie_mode ${params.bowtie_mode} --initial-read-mismatches ${params.read_mismatches} --segment-mismatches ${params.segment_mismatches} --segment-length ${params.segment_length} --read-gap-length ${params.read_gap_length} --read-edit-dist ${params.read_edit_dist} --min-coverage-intron ${params.min_coverage_intron} --max-coverage-intron ${params.max_coverage_intron} --min-segment-intron ${params.min_segment_intron} --max-segment-intron ${params.max_segment_intron} --raw-juncs ${params.raw_juncs_file} --GTF ${params.annotation_file} --transcriptome-index ${params.transcriptome_index_prefix} --insertions ${params.ref_insertions_file} --deletions ${params.ref_deletions_file} --args '${params.other_parameters}' \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/tophat.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/tophat.stderr
    """
}

workflow {
    // Serial execution chain
    tophat()
}
