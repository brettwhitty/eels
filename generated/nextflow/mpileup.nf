#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mpileup
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    i_file_path_1 = ''
    i_file_path_2 = ''
    other_mpileup_parameters = ''
    samtools_exec = ''
    tmp_dir = ''
}

process mpileup_Execution {
    script:
    """
    ${params.bin_dir}/mpileup_wrapper --samtools_exec ${params.samtools_exec} --fasta_file ${params.i_file_path_1} --mpileup_options "${params.other_mpileup_parameters} ${params.i_file_path_2}" --tmp_directory ${params.tmp_dir} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base_2}.mpileup \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE_2}}.stderr
    """
}

workflow {
    // Serial execution chain
    mpileup_Execution()
}
