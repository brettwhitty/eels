#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bsml2interevidence_fasta
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    evidence_list = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    length_cutoff = ''
    output_directory = ''
}

process bsml2interevidence_fasta {
    script:
    """
    ${params.bin_dir}/bsml2interevidence_fasta --input_bsml ${params.i_file_path} --evidence_list ${params.evidence_list} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number} --length_cutoff ${params.length_cutoff} \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    bsml2interevidence_fasta()
}
