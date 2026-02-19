#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pangenome_make_graphs
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    output_directory = ''
    pangenome_input_table = ''
    r_exec = ''
    title = ''
    use_eps = ''
}

process prep_the_R_input_file {
    script:
    """
    ${params.bin_dir}/pangenome_make_graphs --r_script ${params.i_file_path} --input_table ${params.pangenome_input_table} --title '${params.title}' --create_eps '${params.use_eps}' --output_path ${params.output_directory}/${params.iterator_name}/g${params.group_number} --r_exec_path ${params.r_exec}
    """
}

workflow {
    // Serial execution chain
    prep_the_R_input_file()
}
