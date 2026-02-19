#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: outer_membrane_domain
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    pipeline_xml = ''
    project_id_repository = ''
    project_name = ''
    workflow_repository = ''
}

process outer_membrane_domain {
    script:
    """
    ${params.bin_dir}/outer_membrane_domain --input_fsa ${params.i_file_path} --output_bsml ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --id_repository ${params.project_id_repository} --sourcename ${params.output_directory}/${params.iterator_name} --project ${params.project_name}
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_analysis
    """
}

process dtd_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml -d ${params.docs_dir}/bsml3_1.dtd
    """
}

workflow {
    // Serial execution chain
    outer_membrane_domain()
    store_config_params()
    dtd_validation()
}
