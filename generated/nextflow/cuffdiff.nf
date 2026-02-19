#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: cuffdiff
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    cufflinks_bin_dir = ''
    fdr = ''
    group_number = ''
    input_file_1 = ''
    input_file_2 = ''
    iterator_name = ''
    label = ''
    library_type = ''
    max_bundle_frags = ''
    max_mle_iterations = ''
    min_alignment_count = ''
    min_isoform_fraction = ''
    num_threads = ''
    other_args = ''
    other_params = ''
    output_directory = ''
}

process cuffdiff {
    script:
    """
    ${params.bin_dir}/cuffdiff ${params.other_args} --listfile ${params.input_file_1} --gtffile ${params.input_file_2} --labels '${params.label}' --num-threads ${params.num_threads} --min-alignment-count ${params.min_alignment_count} --fdr ${params.fdr} --library-type ${params.library_type} --max-mle-iterations ${params.max_mle_iterations} --min-isoform-fraction ${params.min_isoform_fraction} --max-bundle-frags ${params.max_bundle_frags} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --cufflinks_bin_dir ${params.cufflinks_bin_dir} --args '${params.other_params}' \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/cuffdiff.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/cuffdiff.stderr
    """
}

workflow {
    // Serial execution chain
    cuffdiff()
}
