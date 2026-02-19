#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: promote_gene_prediction
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    cds_fasta = ''
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
    polypeptide_fasta = ''
    project_abbreviation = ''
    project_id_repository = ''
    workflow_repository = ''
}

process promote_gene_prediction {
    script:
    """
    ${params.bin_dir}/promote_gene_prediction --input_bsml ${params.i_file_path} --cds_fasta ${params.cds_fasta} --polypeptide_fasta ${params.polypeptide_fasta} --output_bsml ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --id_repository ${params.project_id_repository} --project ${params.project_abbreviation}
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
    promote_gene_prediction()
    store_config_params()
    dtd_validation()
}
