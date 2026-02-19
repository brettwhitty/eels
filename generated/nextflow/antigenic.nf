#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: antigenic
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    min_length = ''
    output_directory = ''
    pipeline_xml = ''
    project = ''
    project_id_repository = ''
    workflow_repository = ''
}

process antigenic {
    script:
    """
    /usr/local/packages/EMBOSS/bin/antigenic --rformat2 srs --auto --stdout -sequence ${params.i_file_path} -minlen ${params.min_length} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw \
        2>{{TMP_DIR}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

process antigenic2bsml {
    script:
    """
    ${params.bin_dir}/antigenic2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --project ${params.project} --compress_bsml_output ${params.compress_bsml_output} --id_repository ${params.project_id_repository}
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
    antigenic()
    antigenic2bsml()
    store_config_params()
    dtd_validation()
}
