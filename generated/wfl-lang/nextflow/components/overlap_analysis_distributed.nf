#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: overlap_analysis_distributed
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bsml_input_file = ''
    bsml_input_list = ''
    component_name = ''
    cutoff = ''
    evidence_bsml = ''
    output_directory = ''
    rna_bsml = ''
    tmp_dir = ''
}

process mkdir {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}
    """
}

process mkdir {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}
    """
}

process analyze_overlaps {
    script:
    """
    ${params.bin_dir}/overlap_analysis --input_list "${params.bsml_input_list}" --input_file "${params.bsml_input_file}" --rna_bsml ${params.rna_bsml} --evidence_bsml ${params.evidence_bsml} --output_directory ${params.output_directory} --cutoff ${params.cutoff} --flagged_overlaps_file ${params.output_directory}/flagged_overlaps.txt --log ${params.output_directory}/${params.component_name}.log
    """
}

workflow {
    // Serial execution chain
    mkdir()
    mkdir()
    analyze_overlaps()
}
