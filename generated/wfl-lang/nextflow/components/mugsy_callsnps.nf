#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mugsy_callsnps
// Generated from Ergatis component JSON by EELS

params {
    maf_file = ''
    mugsy_mapping_install_dir = ''
    output_directory = ''
}

process index_maf_file {
    script:
    """
    ${params.mugsy_mapping_install_dir}/mafindex.pl ${params.output_directory}/input_maf.idx stdin ${params.maf_file} \
        1>${params.output_directory}/mafindex.stdout
    """
}

workflow {
    // Serial execution chain
    index_maf_file()
}
