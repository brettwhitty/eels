#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: repeatmasker
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
    i_file_name = ''
    i_file_path = ''
    other_opts = ''
    output_directory = ''
    pipeline_xml = ''
    project = ''
    project_id_repository = ''
    repeatmasker_exec = ''
    repeat_def = ''
    workflow_repository = ''
}

process repeatmasker {
    script:
    """
    ${params.repeatmasker_exec} -dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} ${params.repeat_def} ${params.other_opts} ${params.i_file_path}
    """
}

process repeatmasker2bsml {
    script:
    """
    ${params.bin_dir}/repeatmasker2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_name}.out --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --project ${params.project} --id_repository ${params.project_id_repository}
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
    repeatmasker()
    repeatmasker2bsml()
    store_config_params()
    dtd_validation()
}
