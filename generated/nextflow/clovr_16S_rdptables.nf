#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: clovr_16S_rdptables
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    groups_file = ''
    input_file_list = ''
    meta_file = ''
    output_directory = ''
}

process create_rdp_summary_tables {
    script:
    """
    ${params.bin_dir}/clovr16S_rdp_tables.pl -p ${params.output_directory}/RDP -m ${params.meta_file} -r `cat ${params.input_file_list}` -g `cat ${params.groups_file}`
    """
}

workflow {
    // Serial execution chain
    create_rdp_summary_tables()
}
