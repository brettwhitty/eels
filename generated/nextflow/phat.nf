#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: phat
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    docs_dir = ''
    ergatis_dir = ''
    fullphat_exec = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    other_opts = ''
    output_directory = ''
    pipeline_xml = ''
    project = ''
    training_directory = ''
    workflow_repository = ''
}

process phat {
    script:
    """
    ${params.fullphat_exec} -p ${params.training_directory} -noextras -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.phat ${params.other_opts} ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw \
        2>{{TMP_DIR}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

process phat2bsml {
    script:
    """
    ${params.bin_dir}/${params.component_name}2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.gff --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --project ${params.project}
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
    phat()
    phat2bsml()
    store_config_params()
    dtd_validation()
}
