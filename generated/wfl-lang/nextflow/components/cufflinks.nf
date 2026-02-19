#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: cufflinks
// Generated from Ergatis component JSON by EELS

params {
    annotation_file = ''
    bin_dir = ''
    cufflinks_bin_dir = ''
    frag_len_mean = ''
    frag_len_std_dev = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    junc_alpha = ''
    label = ''
    library_type = ''
    max_bundle_frags = ''
    max_bundle_length = ''
    max_intron_len = ''
    max_mle_iterations = ''
    min_frags_per_transfrag = ''
    min_intron_len = ''
    min_isoform_fraction = ''
    num_threads = ''
    other_args = ''
    other_params = ''
    output_directory = ''
    overhang_tolerance = ''
    pre_mrna_fraction = ''
    small_anchor_fraction = ''
    trim3_avgcov_thresh = ''
    trim3_dropoff_frac = ''
}

process cufflinks {
    script:
    """
    ${params.bin_dir}/cufflinks ${params.other_args} --infile ${params.i_file_path} --annotation ${params.annotation_file} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --library-type ${params.library_type} --frag-len-mean ${params.frag_len_mean} --frag-len-std-dev ${params.frag_len_std_dev} --max-mle-iterations ${params.max_mle_iterations} --max-bundle-frags ${params.max_bundle_frags} --label ${params.label} --min-isoform-fraction ${params.min_isoform_fraction} --pre-mrna-fraction ${params.pre_mrna_fraction} --min-intron-length ${params.min_intron_len} --max-intron-length ${params.max_intron_len} --junc-alpha ${params.junc_alpha} --small-anchor-fraction ${params.small_anchor_fraction} --min-frags-per-transfrag ${params.min_frags_per_transfrag} --overhang-tolerance ${params.overhang_tolerance} --max-bundle-length ${params.max_bundle_length} --trim-3-avgcov-thresh ${params.trim3_avgcov_thresh} --trim-3-dropoff-frac ${params.trim3_dropoff_frac} --num-threads ${params.num_threads} --cufflinks_bin_dir ${params.cufflinks_bin_dir} --args '${params.other_params}' \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/cufflinks.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/cufflinks.stderr
    """
}

workflow {
    // Serial execution chain
    cufflinks()
}
