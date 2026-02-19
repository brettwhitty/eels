#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bowtie_build
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bowtie_bin_dir = ''
    bowtie_index_prefix = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    other_args = ''
    other_parameters = ''
    output_directory = ''
}

process bowtie_build {
    script:
    """
    ${params.bin_dir}/bowtie_build ${params.other_args} --reffile ${params.i_file_path} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --prefix ${params.bowtie_index_prefix} --bowtie_bin_dir ${params.bowtie_bin_dir} --args '${params.other_parameters}' \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/bowtie_build.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/bowtie_build.stderr
    """
}

workflow {
    // Serial execution chain
    bowtie_build()
}
