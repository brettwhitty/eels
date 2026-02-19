#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: priam_ec_assignment
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    docs_dir = ''
    ergatis_dir = ''
    e_value_cutoff = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    pipeline_xml = ''
    workflow_repository = ''
}

process priam_ec_assignment {
    script:
    """
    ${params.bin_dir}/assign_ec_from_rps --input_file ${params.i_file_path} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --evalue_cutoff ${params.e_value_cutoff}
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id assign_ec_from_rps_analysis
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
    priam_ec_assignment()
    store_config_params()
    dtd_validation()
}
