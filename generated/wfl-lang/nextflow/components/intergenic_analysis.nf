#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: intergenic_analysis
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
    minimum_gene_length = ''
    output_directory = ''
    pipeline_xml = ''
    project = ''
    project_id_repository = ''
    workflow_repository = ''
}

process intergenic_analysis {
    script:
    """
    ${params.bin_dir}/intergenic_analysis --input_bsml ${params.i_file_path} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --id_repository ${params.project_id_repository} --minimum_gene_length ${params.minimum_gene_length} --sourcename ${params.output_directory}/${params.iterator_name} --project ${params.project}
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
    intergenic_analysis()
    store_config_params()
    dtd_validation()
}
