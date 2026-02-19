#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: combine_ncRNA_alignments
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
    other_bsml_lists = ''
    output_directory = ''
    pipeline_xml = ''
    project_id_repository = ''
    project_name = ''
    workflow_repository = ''
}

process combine_ncRNA_alignments {
    script:
    """
    ${params.bin_dir}/combine_ncRNA_alignemnts -w -l -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw ${params.i_file_path} --bsml_input ${params.i_file_path} --other_bsml_lists ${params.other_bsml_lists} --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --id_repository ${params.project_id_repository} --project ${params.project_name}
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
    combine_ncRNA_alignments()
    store_config_params()
    dtd_validation()
}
