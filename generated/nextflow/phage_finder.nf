#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: phage_finder
// Generated from Ergatis component JSON by EELS

params {
    aragorn_list = ''
    bin_dir = ''
    btab_list = ''
    group_number = ''
    info_file = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    other_opts = ''
    output_directory = ''
    phage_finder_dir = ''
    polypeptide_multi_fsa = ''
    trna_scan_list = ''
}

process phage_finder {
    script:
    """
    ${params.bin_dir}/run_phage_finder --input_bsml_file ${params.i_file_path} --input_polypeptide_multi_fsa ${params.polypeptide_multi_fsa} --btab_list ${params.btab_list} --aragorn_list ${params.aragorn_list} --trna_scan_list ${params.trna_scan_list} --info_file ${params.info_file} --other_opts ${params.other_opts} --tmp_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw --phage_finder_dir ${params.phage_finder_dir}
    """
}

workflow {
    // Serial execution chain
    phage_finder()
}
