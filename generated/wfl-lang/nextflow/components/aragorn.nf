#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: aragorn
// Generated from Ergatis component JSON by EELS

params {
    aragorn_exec = ''
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
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

process aragorn {
    script:
    """
    ${params.aragorn_exec} -w -l -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw ${params.i_file_path}
    """
}

process aragorn2bsml {
    script:
    """
    ${params.bin_dir}/aragorn2bsml --fasta_input ${params.i_file_path} --input_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --project ${params.project_name} --id_repository ${params.project_id_repository} --compress_output ${params.compress_bsml_output}
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
    aragorn()
    aragorn2bsml()
    store_config_params()
    dtd_validation()
}
