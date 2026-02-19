#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: prodigal
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
    output_format = ''
    pipeline_xml = ''
    prodigal_exec = ''
    prodigal_opts = ''
    project_abbreviation = ''
    project_id_repository = ''
    translation_table = ''
    workflow_repository = ''
}

process prodigal {
    script:
    """
    ${params.prodigal_exec} ${params.prodigal_opts} -f ${params.output_format} -g ${params.translation_table} -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.predict \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

process prodigal2bsml {
    script:
    """
    ${params.bin_dir}/prodigal2bsml --fasta_input ${params.i_file_path} --input_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.predict --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --project ${params.project_abbreviation} --id_repository ${params.project_id_repository}
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
    prodigal()
    prodigal2bsml()
    store_config_params()
    dtd_validation()
}
