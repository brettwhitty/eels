#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: genemark
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    docs_dir = ''
    ergatis_dir = ''
    gmhmme3_exec = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    model_file = ''
    output_directory = ''
    pipeline_xml = ''
    project = ''
    workflow_repository = ''
}

process genemark {
    script:
    """
    ${params.gmhmme3_exec} -m ${params.model_file} ${params.i_file_path}
    """
}

process migrate_output_file {
    script:
    """
    mv ${params.i_file_path}.lst ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.genemark.raw
    """
}

process genemark2bsml {
    script:
    """
    ${params.bin_dir}/genemark2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.genemark.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.genemark.bsml --fasta_file ${params.i_file_path} --project ${params.project} --sequence_id ${params.i_file_base}
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
    genemark()
    migrate_output_file()
    genemark2bsml()
    store_config_params()
    dtd_validation()
}
