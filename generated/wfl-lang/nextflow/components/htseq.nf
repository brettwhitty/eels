#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: htseq
// Generated from Ergatis component JSON by EELS

params {
    annotation_file = ''
    attribute_id = ''
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    min_qual = ''
    mode = ''
    other_args = ''
    other_params = ''
    output_directory = ''
    python_bin_dir = ''
    python_lib_dir = ''
    stranded = ''
    type = ''
}

process htseq {
    script:
    """
    ${params.bin_dir}/htseq ${params.other_args} --infile ${params.i_file_path} --annotation ${params.annotation_file} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --mode ${params.mode} --type ${params.type} --minqual ${params.min_qual} --stranded ${params.stranded} --idattr ${params.attribute_id} --params '${params.other_params}' --python_bin_dir ${params.python_bin_dir} --python_lib_dir ${params.python_lib_dir} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/htseq.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/htseq.stderr
    """
}

workflow {
    // Serial execution chain
    htseq()
}
