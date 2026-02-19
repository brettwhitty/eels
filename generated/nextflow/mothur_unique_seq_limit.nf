#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mothur_unique_seq_limit
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    faux_fasta = ''
    faux_names = ''
    input_file_list = ''
    names_list = ''
    seqlimit = ''
}

process mothur_check_for_unique_seq_limit {
    script:
    """
    ${params.bin_dir}/mothur_unique_seq_limit.pl -f `cat ${params.input_file_list}` -g `cat ${params.names_list}` -n ${params.seqlimit} -e ${params.faux_fasta} -m ${params.faux_names}
    """
}

workflow {
    // Serial execution chain
    mothur_check_for_unique_seq_limit()
}
