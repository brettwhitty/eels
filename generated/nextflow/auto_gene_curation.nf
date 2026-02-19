#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: auto_gene_curation
// Generated from Ergatis component JSON by EELS

params {
    ber_input = ''
    bin_dir = ''
    component_config = ''
    component_name = ''
    docs_dir = ''
    ergatis_dir = ''
    hmm_info_db = ''
    hmm_input = ''
    i_file_base = ''
    i_file_path = ''
    names_dump = ''
    nodes_dump = ''
    output_directory = ''
    pipeline_xml = ''
    workflow_repository = ''
}

process auto_gene_curation {
    script:
    """
    ${params.bin_dir}/auto_gene_curation --input_file ${params.i_file_path} --output_dir ${params.output_directory} --ber_input ${params.ber_input} --hmm_input ${params.hmm_input} --hmm_info_db ${params.hmm_info_db} --names_dump ${params.names_dump} --nodes_dump ${params.nodes_dump} --base_name ${params.i_file_base}
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.i_file_base}.all.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_analysis
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.i_file_base}.new.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_analysis
    """
}

process dtd_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl ${params.output_directory}/${params.i_file_base}.all.bsml -d ${params.docs_dir}/bsml3_1.dtd
    """
}

process dtd_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl ${params.output_directory}/${params.i_file_base}.new.bsml -d ${params.docs_dir}/bsml3_1.dtd
    """
}

workflow {
    // Serial execution chain
    auto_gene_curation()
    store_config_params()
    store_config_params()
    dtd_validation()
    dtd_validation()
}
