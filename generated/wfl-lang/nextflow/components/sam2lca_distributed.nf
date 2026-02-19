#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: sam2lca_distributed
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    gi2tax = ''
    host = ''
    input_file_list = ''
    ncbitax = ''
    output_directory = ''
    samtools_exec = ''
    taxoncoll = ''
    taxondb = ''
    tmp_dir = ''
}

process Get_lowest_common_ancestor_from_SAM_reads {
    script:
    """
    ${params.bin_dir}/sam2lca --input_list ${params.input_file_list} --tax_id_file ${params.gi2tax} --names_file ${params.ncbitax}/names.dmp --nodes_file ${params.ncbitax}/nodes.dmp --output_file ${params.output_directory}/sam2lca.out --tmp_dir ${params.tmp_dir} --db ${params.taxondb} --host ${params.host} --collection ${params.taxoncoll} --samtools_path ${params.samtools_exec} \
        1>${params.output_directory}/sam2lca.stdout \
        2>{{OUTPUT_DIRECTORY}}/sam2lca.stderr
    """
}

workflow {
    // Serial execution chain
    Get_lowest_common_ancestor_from_SAM_reads()
}
