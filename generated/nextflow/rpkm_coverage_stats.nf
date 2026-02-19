#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: rpkm_coverage_stats
// Generated from Ergatis component JSON by EELS

params {
    annotation_file = ''
    annotation_file_type = ''
    attribute_id = ''
    bedtools_bin_dir = ''
    bin_dir = ''
    feature_id = ''
    groupby_id = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    other_args = ''
    output_directory = ''
    reference_fasta = ''
    region_type = ''
    samtools_bin_dir = ''
}

process rpkm_coverage_stats {
    script:
    """
    ${params.bin_dir}/rpkm_coverage_stats ${params.other_args} --reffile ${params.reference_fasta} --infile ${params.i_file_path} --annotation ${params.annotation_file} --annotationfiletype ${params.annotation_file_type} --regiontype ${params.region_type} --feature ${params.feature_id} --attribute ${params.attribute_id} --groupby ${params.groupby_id} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --samtools_bin_dir ${params.samtools_bin_dir} --bedtools_bin_dir ${params.bedtools_bin_dir} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/rpkm_coverage_stats.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/rpkm_coverage_stats.stderr
    """
}

workflow {
    // Serial execution chain
    rpkm_coverage_stats()
}
