#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: genbank2gtf
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    other_args = ''
    output_directory = ''
    source = ''
}

process genbank2gtf {
    script:
    """
    ${params.bin_dir}/genbank2gtf ${params.other_args} --genbank ${params.i_file_path} --source ${params.source} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/genbank2gtf.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/genbank2gtf.stderr
    """
}

workflow {
    // Serial execution chain
    genbank2gtf()
}
