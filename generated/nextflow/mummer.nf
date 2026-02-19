#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mummer
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    mummer_options = ''
    output_directory = ''
    query_fasta = ''
}

process mummer {
    script:
    """
    /usr/local/bin/mummer ${params.mummer_options} ${params.i_file_path} ${params.query_fasta} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.mums
    """
}

process mummertab {
    script:
    """
    ${params.bin_dir}/mummertab stdin ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.mums \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.tab
    """
}

workflow {
    // Serial execution chain
    mummer()
    mummertab()
}
