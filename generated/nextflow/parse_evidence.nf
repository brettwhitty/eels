#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: parse_evidence
// Generated from Ergatis component JSON by EELS

params {
    annotate_on = ''
    bin_dir = ''
    bsml_feature_lookup_list = ''
    component_name = ''
    evidence_type = ''
    input_file_list = ''
    other_parser_options = ''
    output_directory = ''
}

process parse_evidence {
    script:
    """
    ${params.bin_dir}/parse_evidence --input_list ${params.input_file_list} --output ${params.output_directory}/${params.component_name}.${params.evidence_type}.tab --evidence_type ${params.evidence_type} --bsml_feature_lookup_list ${params.bsml_feature_lookup_list} --annotate_on ${params.annotate_on} --other_options '${params.other_parser_options}'
    """
}

workflow {
    // Serial execution chain
    parse_evidence()
}
