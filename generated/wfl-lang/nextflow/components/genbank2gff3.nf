#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: genbank2gff3
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    feat_type = ''
    genbank_file = ''
    gff3_file = ''
    other_args = ''
}

process genbank2gff3 {
    script:
    """
    ${params.bin_dir}/genbank2gff3 ${params.other_args} --gb_file ${params.genbank_file} --gff3_file ${params.gff3_file} --feat_type ${params.feat_type} \
        1>${params.output_directory}/genbank2gff3.stdout \
        2>{{OUTPUT_DIRECTORY}}/genbank2gff3.stderr
    """
}

workflow {
    // Serial execution chain
    genbank2gff3()
}
