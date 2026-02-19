#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: predict_operons
// Generated from Ergatis component JSON by EELS

params {
    abbr = ''
    bin_dir = ''
    gff_file = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
    reference_fasta = ''
}

process predict_operons {
    script:
    """
    ${params.bin_dir}/predict_operons --bin_dir ${params.bin_dir} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --wig_file ${params.i_file_path} --gff ${params.gff_file} --reference ${params.reference_fasta} --sample ${params.abbr} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    predict_operons()
}
