#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: extract_snp_regions
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    flanking_bases = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
    snp_panel_list = ''
}

process extract_snp_regions {
    script:
    """
    ${params.bin_dir}/extract_snp_regions --ref_genbank ${params.i_file_path} --snp_positions ${params.snp_panel_list} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --flanking_bases '${params.flanking_bases}' \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    extract_snp_regions()
}
