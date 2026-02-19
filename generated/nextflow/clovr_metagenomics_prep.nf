#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: clovr_metagenomics_prep
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    input_file_list = ''
    mapping_file = ''
    output_prefix = ''
}

process clovr_metagenomics_prep {
    script:
    """
    ${params.bin_dir}/clovr_metagenomics_prep.pl -f ${params.input_file_list} -m `cat ${params.mapping_file}` -p ${params.output_prefix} \
        1>${params.output_directory}/${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    clovr_metagenomics_prep()
}
