#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: filter_lgt_class_c_genes
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bitscore_thresh = ''
    component_name = ''
    hscore_thresh = ''
    output_directory = ''
    outside_file = ''
    sister_file = ''
}

process get_best_blast_hit_by_bitscore____sister_ {
    script:
    """
    sort -k1,1 -k12,12nr -k11,11n ${params.sister_file} | sort -u -k1,1 --merge \
        1>${params.output_directory}/${params.component_name}.sister.best.m8
    """
}

process get_best_blast_hit_by_bitscore____outsie_ {
    script:
    """
    sort -k1,1 -k12,12nr -k11,11n ${params.outside_file} | sort -u -k1,1 --merge \
        1>${params.output_directory}/${params.component_name}.outside.best.m8
    """
}

process calculate_h_score_and_classify_c_class_genes {
    script:
    """
    ${params.bin_dir}/classify_class_c_genes --sister_file ${params.output_directory}/${params.component_name}.sister.best.m8 --outside_file ${params.output_directory}/${params.component_name}.outside.best.m8 --bitscore_thresh ${params.bitscore_thresh} --hscore_thresh ${params.hscore_thresh} --output_dir ${params.output_directory} \
        1>${params.output_directory}/classify_class_c_genes.stdout \
        2>{{OUTPUT_DIRECTORY}}/classify_class_c_genes.stderr
    """
}

workflow {
    // Serial execution chain
    get_best_blast_hit_by_bitscore____sister_()
    get_best_blast_hit_by_bitscore____outsie_()
    calculate_h_score_and_classify_c_class_genes()
}
