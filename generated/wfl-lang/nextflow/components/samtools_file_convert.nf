#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: samtools_file_convert
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    input_file_format = ''
    iterator_name = ''
    i_file_path = ''
    options = ''
    other_args = ''
    output_directory = ''
    reference_fasta = ''
    samtools_bin_dir = ''
    samtools_sort_parameters = ''
    samtools_view_parameters = ''
}

process samtools_file_convert {
    script:
    """
    ${params.bin_dir}/samtools_file_convert ${params.other_args} --infile ${params.i_file_path} --infile_format ${params.input_file_format} --options ${params.options} --reffile ${params.reference_fasta} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --samtools_bin_dir ${params.samtools_bin_dir} --samtools_view_options ${params.samtools_view_parameters} --samtools_sort_options ${params.samtools_sort_parameters} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/samtools_file_convert.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/samtools_file_convert.stderr
    """
}

workflow {
    // Serial execution chain
    samtools_file_convert()
}
