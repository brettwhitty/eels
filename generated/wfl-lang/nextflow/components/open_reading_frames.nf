#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: open_reading_frames
// Generated from Ergatis component JSON by EELS

params {
    assume_stops = ''
    beginning_as_start = ''
    bin_dir = ''
    codon_table = ''
    end_as_stop = ''
    force_methionine = ''
    frames = ''
    full_orfs = ''
    group_number = ''
    gzip_output = ''
    header_additions = ''
    iterator_name = ''
    i_file_path = ''
    max_orf_size = ''
    min_orf_size = ''
    min_unmasked_size = ''
    output_directory = ''
}

process open_reading_frames {
    script:
    """
    ${params.bin_dir}/open_reading_frames --input_file ${params.i_file_path} --translation_table ${params.codon_table} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --gzip_output ${params.gzip_output} --beginning_as_start ${params.beginning_as_start} --end_as_stop ${params.end_as_stop} --assume_stops ${params.assume_stops} --full_orfs ${params.full_orfs} --min_orf_size ${params.min_orf_size} --max_orf_size ${params.max_orf_size} --min_unmasked_size ${params.min_unmasked_size} --frames ${params.frames} --force_methionine ${params.force_methionine} --header_additions '${params.header_additions}'
    """
}

workflow {
    // Serial execution chain
    open_reading_frames()
}
