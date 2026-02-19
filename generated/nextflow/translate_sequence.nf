#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: translate_sequence
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    cleanup = ''
    component_config = ''
    component_name = ''
    docs_dir = ''
    ergatis_dir = ''
    frame = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    multifasta_output = ''
    output_directory = ''
    pipeline_xml = ''
    project_id_repository = ''
    project_name = ''
    regions = ''
    seqs_per_fasta = ''
    table = ''
    transeq_exec = ''
    workflow_repository = ''
}

process translate_sequence {
    script:
    """
    ${params.bin_dir}/translate_sequence --input ${params.i_file_path} --regions '${params.regions}' --frame ${params.frame} --table ${params.table} --multifasta_output ${params.multifasta_output} --seqs_per_fasta ${params.seqs_per_fasta} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number} --id_repository ${params.project_id_repository} --cleanup ${params.cleanup} --project ${params.project_name} --transeq_bin ${params.transeq_exec} \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
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
    translate_sequence()
    store_config_params()
    dtd_validation()
}
