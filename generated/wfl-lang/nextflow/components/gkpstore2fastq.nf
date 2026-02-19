#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: gkpstore2fastq
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    gatekeeper_61 = ''
    gatekeeper_70 = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
}

process gkpstore2fastq {
    script:
    """
    ${params.bin_dir}/gkpstore2fastq --input_gkpstore ${params.i_file_path} --output_prefix ${params.i_file_base} --output_directory ${params.output_directory}/${params.iterator_name}/g${params.group_number} --gatekeeper_exec_6-1 ${params.gatekeeper_61} --gatekeeper_exec_7-0 ${params.gatekeeper_70} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bwa_align_exec.ref1.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.bwa_align_exec.ref1.stderr
    """
}

process cat_files {
    script:
    """
    /bin/cat ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.unmated.fastq ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.paired.fastq \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.all.fastq
    """
}

workflow {
    // Serial execution chain
    gkpstore2fastq()
    cat_files()
}
