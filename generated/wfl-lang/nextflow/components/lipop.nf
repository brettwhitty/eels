#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: lipop
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    cutoff = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    lipop_exec = ''
    output_directory = ''
    pipeline_xml = ''
    project_abbr = ''
    project_id_repository = ''
    workflow_repository = ''
}

process lipop {
    script:
    """
    ${params.lipop_exec} ${params.i_file_path} -short -cutoff ${params.cutoff} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw
    """
}

process lipop2bsml {
    script:
    """
    ${params.bin_dir}/lipop2bsml --input_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw --input_fasta ${params.i_file_path} --id_repository ${params.project_id_repository} --project ${params.project_abbr} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --analysis_id ${params.component_name}_analysis --sourcename ${params.output_directory} \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
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
    lipop()
    lipop2bsml()
    store_config_params()
    dtd_validation()
}
