#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: RNAmmer
// Generated from Ergatis component JSON by EELS

params {
    args = ''
    bin_dir = ''
    component_config = ''
    component_name = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    kingdom = ''
    molecules = ''
    output_directory = ''
    pipeline_xml = ''
    project_abbreviation = ''
    project_id_repository = ''
    rnammer_exec = ''
    workflow_repository = ''
}

process RNAmmer {
    script:
    """
    ${params.rnammer_exec} -S ${params.kingdom} -m ${params.molecules} -gff ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.gff -f ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fsa ${params.args} ${params.i_file_path}  \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

process RNAmmer2bsml {
    script:
    """
    ${params.bin_dir}/rnammer2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.gff --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --fasta_input ${params.i_file_path} --id_repository ${params.project_id_repository} --project ${params.project_abbreviation} \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
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
    RNAmmer()
    RNAmmer2bsml()
    store_config_params()
    dtd_validation()
}
