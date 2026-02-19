#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: islandpath
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    dimob_path = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    iterator1 = ''
    nuc_file_path = ''
    other_opts = ''
    output_directory = ''
    pipeline_xml = ''
    project = ''
    project_id_repository = ''
    prot_file_name = ''
    prot_file_path = ''
    ptt_file_path = ''
    workflow_repository = ''
}

process dimob {
    script:
    """
    ${params.dimob_path} ${params.other_opts} ${params.prot_file_path} ${params.nuc_file_path} ${params.ptt_file_path} \
        1>${params.output_directory}/${params.iterator1}/g${params.group_number}/${params.prot_file_name}.out
    """
}

process islandpath2bsml {
    script:
    """
    ${params.bin_dir}/islandpath2bsml --input ${params.output_directory}/${params.iterator1}/g${params.group_number}/${params.prot_file_name}.out --output ${params.output_directory}/${params.iterator1}/g${params.group_number}/${params.prot_file_name}.bsml --project ${params.project} --id_repository ${params.project_id_repository}
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator1}/g${params.group_number}/${params.prot_file_name}.${params.component_name}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_analysis
    """
}

process dtd_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl ${params.output_directory}/${params.iterator1}/g${params.group_number}/${params.prot_file_name}.${params.component_name}.bsml -d ${params.docs_dir}/bsml3_1.dtd
    """
}

workflow {
    // Serial execution chain
    dimob()
    islandpath2bsml()
    store_config_params()
    dtd_validation()
}
