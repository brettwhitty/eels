#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pmarks2bsml
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    pipeline_xml = ''
    project_abbreviation = ''
    project_id_repository = ''
    workflow_repository = ''
}

process pmarks2bsml {
    script:
    """
    ${params.bin_dir}/pmarks2bsml --input_file ${params.i_file_path}.pmarks --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.pmarks.bsml --project ${params.project_abbreviation} --id_repository ${params.project_id_repository} --fasta_input ${params.i_file_path}
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.pmarks.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id pseudomolecule_analysis
    """
}

process dtd_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.pmarks.bsml -d ${params.docs_dir}/bsml3_1.dtd
    """
}

workflow {
    // Serial execution chain
    pmarks2bsml()
    store_config_params()
    dtd_validation()
}
