#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: targetp
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    chloroplast_prediction_cutoff = ''
    component_config = ''
    component_name = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    mitochondrial_prediction_cutoff = ''
    organism_type = ''
    other_location_prediction_cutoff = ''
    output_directory = ''
    pipeline_xml = ''
    project = ''
    project_id_repository = ''
    secretory_pathway_prediction_cutoff = ''
    targetp_exec = ''
    workflow_repository = ''
}

process targetp {
    script:
    """
    ${params.targetp_exec} -${params.organism_type} -c -p ${params.chloroplast_prediction_cutoff} -s ${params.secretory_pathway_prediction_cutoff} -t ${params.mitochondrial_prediction_cutoff} -o ${params.other_location_prediction_cutoff} ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

process targetp2bsml {
    script:
    """
    ${params.bin_dir}/targetp2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --project ${params.project} --sequence_id ${params.i_file_base} --id_repository ${params.project_id_repository}
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
    targetp()
    targetp2bsml()
    store_config_params()
    dtd_validation()
}
