#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fgenesh
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    docs_dir = ''
    ergatis_dir = ''
    fgenesh_exec = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    parameter_file = ''
    pipeline_xml = ''
    project = ''
    project_id_repository = ''
    workflow_repository = ''
}

process fgenesh {
    script:
    """
    ${params.fgenesh_exec} ${params.parameter_file} ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fgenesh.raw
    """
}

process fgenesh2bsml {
    script:
    """
    ${params.bin_dir}/fgenesh2bsml --input_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fgenesh.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fgenesh.bsml --fasta_input ${params.i_file_path} --project ${params.project} --programversion 'current' --sourcename ${params.output_directory}/dummy/dir --id_repository ${params.project_id_repository}
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
    fgenesh()
    fgenesh2bsml()
    store_config_params()
    dtd_validation()
}
