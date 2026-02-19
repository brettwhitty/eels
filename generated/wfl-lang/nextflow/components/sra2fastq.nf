#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: sra2fastq
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    data_directory = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
    sra_tools_bin = ''
}

process Convert_sra_file_to_fastq {
    script:
    """
    ${params.bin_dir}/sra2fastq --data_dir ${params.data_directory} --sratoolkit ${params.sra_tools_bin} --input_file ${params.i_file_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.sra2fastq_exec.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.sra2fastq_exec.stderr
    """
}

workflow {
    // Serial execution chain
    Convert_sra_file_to_fastq()
}
