#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: btab2taxon
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    gi2tax = ''
    host = ''
    idx_directory = ''
    i_file_path = ''
    ncbitax = ''
    overwrite = ''
    taxoncoll = ''
    taxondb = ''
}

process btab2taxon {
    script:
    """
    ${params.bin_dir}/btab2taxon --input ${params.i_file_path} --ncbitax ${params.ncbitax} --gitax ${params.gi2tax} --dbhost ${params.host} --taxondb ${params.taxondb} --taxoncoll ${params.taxoncoll} --overwrite ${params.overwrite} --idx_dir ${params.idx_directory} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    btab2taxon()
}
