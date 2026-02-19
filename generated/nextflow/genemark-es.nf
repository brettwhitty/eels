#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: genemark-es
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    docs_dir = ''
    ergatis_dir = ''
    genemarkes_exec = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    other_opts = ''
    output_directory = ''
    pipeline_xml = ''
    project = ''
    project_id_repository = ''
    tmp_dir = ''
    workflow_repository = ''
}

process genemark {
    script:
    """
    ${params.bin_dir}/run_genemark-es --input_file ${params.i_file_path} --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.gtf --tmp_dir ${params.tmp_dir}/${params.iterator_name}/g${params.group_number} --other_opts ${params.other_opts} --executable ${params.genemarkes_exec}
    """
}

process genemarkes2bsml {
    script:
    """
    ${params.bin_dir}/genemarkes2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.gtf --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --fasta_file ${params.i_file_path} --project ${params.project} --sequence_id ${params.i_file_base} --id_repository ${params.project_id_repository}
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
    genemark()
    genemarkes2bsml()
    store_config_params()
    dtd_validation()
}
