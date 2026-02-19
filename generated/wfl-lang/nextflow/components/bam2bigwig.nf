#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bam2bigwig
// Generated from Ergatis component JSON by EELS

params {
    bedtools_bin_dir = ''
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    other_args = ''
    output_directory = ''
    reference_fasta = ''
    samtools_bin_dir = ''
    stranded = ''
    ucsc_util_dir = ''
}

process bam2bigwig {
    script:
    """
    ${params.bin_dir}/bam2bigwig ${params.other_args} --infile ${params.i_file_path} --reffile ${params.reference_fasta} --stranded ${params.stranded} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --ucsc_util_dir ${params.ucsc_util_dir} --bedtools_bin_dir ${params.bedtools_bin_dir} --samtools_bin_dir ${params.samtools_bin_dir} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/bam2bigwig.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/bam2bigwig.stderr
    """
}

workflow {
    // Serial execution chain
    bam2bigwig()
}
