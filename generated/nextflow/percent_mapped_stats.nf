#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: percent_mapped_stats
// Generated from Ergatis component JSON by EELS

params {
    annotation_file = ''
    anno_format = ''
    attribute_id = ''
    bedtools_bin_dir = ''
    bin_dir = ''
    feature_type = ''
    groupby_id = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    org_type = ''
    other_parameters = ''
    output_directory = ''
    reference_fasta = ''
    samtools_bin_dir = ''
}

process percent_mapped_stats {
    script:
    """
    ${params.bin_dir}/percent_mapped_stats --reffile ${params.reference_fasta} --infile ${params.i_file_path} --annotation ${params.annotation_file} --annotationfiletype ${params.anno_format} --feature ${params.feature_type} --attribute ${params.attribute_id} --groupby ${params.groupby_id} --org-type ${params.org_type} --args ${params.other_parameters} --bedtools_bin_dir ${params.bedtools_bin_dir} --samtools_bin_dir ${params.samtools_bin_dir} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/percent_mapped_stats.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/percent_mapped_stats.stderr
    """
}

workflow {
    // Serial execution chain
    percent_mapped_stats()
}
