#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: make_snp_lists
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    input_file_1 = ''
    input_file_2 = ''
    iterator_name = ''
    output_directory = ''
    parsed_blast_list = ''
}

process make_snp_lists {
    script:
    """
    ${params.bin_dir}/make_snp_lists --ref_genbank ${params.input_file_1} --snp_positions ${params.input_file_2} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --blast_list ${params.parsed_blast_list} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    make_snp_lists()
}
