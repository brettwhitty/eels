#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fastq_to_CA
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    fastqtoca_exec = ''
    fastq_type = ''
    input_file = ''
    input_file_list = ''
    insert_size = ''
    library = ''
    orientation = ''
    output_directory = ''
}

process fastqToCA {
    script:
    """
    ${params.bin_dir}/fastq_to_CA --fastq_to_CA_exe ${params.fastqtoca_exec} --fastq_file ${params.input_file} --fastq_file_list ${params.input_file_list} --insert_size "${params.insert_size}" --library ${params.library} --type ${params.fastq_type} --reads_orientation ${params.orientation} --output ${params.output_directory}/${params.library}.frg \
        1>${params.output_directory}/fastqToCA.stdout \
        2>{{OUTPUT_DIRECTORY}}/fastqToCA.stderr
    """
}

workflow {
    // Serial execution chain
    fastqToCA()
}
