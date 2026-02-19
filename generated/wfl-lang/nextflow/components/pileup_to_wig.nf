#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pileup_to_wig
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
}

process pileup2wig_script {
    script:
    """
    ${params.bin_dir}/pileup2wig --v --p ${params.i_file_path} --o ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.pileup2wig.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.pileup2wig.stderr
    """
}

workflow {
    // Serial execution chain
    pileup2wig_script()
}
