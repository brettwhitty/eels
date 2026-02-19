#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: lipoprotein_motif
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    is_mycoplasm = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    pipeline_xml = ''
    project_id_repository = ''
    workflow_repository = ''
}

process lipoprotein_motif {
    script:
    """
    ${params.bin_dir}/lipoprotein_motif --input ${params.i_file_path} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --gzip_output ${params.compress_bsml_output} --id_repository ${params.project_id_repository} --is_mycoplasm ${params.is_mycoplasm}
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
    lipoprotein_motif()
    store_config_params()
    dtd_validation()
}
