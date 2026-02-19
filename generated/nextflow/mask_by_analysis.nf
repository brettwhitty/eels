#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mask_by_analysis
// Generated from Ergatis component JSON by EELS

params {
    analysis_types = ''
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_bsml = ''
    docs_dir = ''
    ergatis_dir = ''
    feature_classes = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    mask_character = ''
    output_directory = ''
    pipeline_xml = ''
    random = ''
    softmask = ''
    workflow_repository = ''
}

process mask_by_analysis {
    script:
    """
    ${params.bin_dir}/mask_by_analysis --input ${params.i_file_path} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number} --output_prefix ${params.i_file_base}.${params.component_name} --analysis_types '${params.analysis_types}' --feature_types '${params.feature_classes}' --mask_char '${params.mask_character}' --random '${params.random}' --softmask '${params.softmask}' --gzip_output ${params.compress_bsml}
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_analysis
    """
}

process dtd_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml -d ${params.docs_dir}/bsml3_1.dtd
    """
}

workflow {
    // Serial execution chain
    mask_by_analysis()
    store_config_params()
    dtd_validation()
}
