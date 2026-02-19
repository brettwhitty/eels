#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bsml2featurerelationships
// Generated from Ergatis component JSON by EELS

params {
    add_assembly = ''
    add_feature_coordinates = ''
    bin_dir = ''
    input_directory = ''
    input_file = ''
    input_file_list = ''
    output_directory = ''
    output_order = ''
}

process bsml2feature_relationships {
    script:
    """
    ${params.bin_dir}/bsml2featurerelationships --bsml_input '${params.input_file}' --bsml_list '${params.input_file_list}' --bsml_dir '${params.input_directory}' --output ${params.output_directory}/bsml2featurerelationships.mapping.list --output_order ${params.output_order} --add_assembly ${params.add_assembly} --add_feature_coordinates ${params.add_feature_coordinates}
    """
}

workflow {
    // Serial execution chain
    bsml2feature_relationships()
}
