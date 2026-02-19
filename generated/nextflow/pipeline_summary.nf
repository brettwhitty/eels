#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pipeline_summary
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    docs_dir = ''
    ergatis_dir = ''
    i_file_base = ''
    output_directory = ''
    pipeline_xml = ''
    workflow_repository = ''
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.i_file_base}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_analysis
    """
}

process dtd_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl ${params.output_directory}/${params.i_file_base}.bsml -d ${params.docs_dir}/bsml3_1.dtd
    """
}

workflow {
    // Serial execution chain
    store_config_params()
    dtd_validation()
}
