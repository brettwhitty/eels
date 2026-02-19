#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bsml2tbl
// Generated from Ergatis component JSON by EELS

params {
    all_ec_numbers = ''
    bin_dir = ''
    export_mrna_features = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    percent_n_cutoff = ''
}

process bsml2tbl {
    script:
    """
    ${params.bin_dir}/bsml2tbl --input ${params.i_file_path} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.tbl --mrna ${params.export_mrna_features} --ec_all ${params.all_ec_numbers} --percent_n_cutoff ${params.percent_n_cutoff} \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    bsml2tbl()
}
