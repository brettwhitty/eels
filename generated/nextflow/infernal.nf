#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: infernal
// Generated from Ergatis component JSON by EELS

params {
    annot_bsml_list = ''
    bin_dir = ''
    cmsearch_exec = ''
    cm_file = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    default_type = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    hmm_cm_table = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    other_opts = ''
    output_directory = ''
    pipeline_xml = ''
    project = ''
    project_id_repository = ''
    sequence_list = ''
    stockholm_path = ''
    tmp_dir = ''
    workflow_repository = ''
}

process infernal {
    script:
    """
    ${params.bin_dir}/run_cmsearch --input_file ${params.i_file_path} --tmp_dir ${params.tmp_dir} --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --sequence_list ${params.sequence_list} --flanking_sequence 50 --hmm_cm_table ${params.hmm_cm_table} --cm_file ${params.cm_file} --other_opts ${params.other_opts} --cmsearch_bin ${params.cmsearch_exec}
    """
}

process infernal2bsml {
    script:
    """
    ${params.bin_dir}/infernal2bsml --query_file_path ${params.i_file_path} --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw.tbl --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --project ${params.project} --stockholm_path ${params.stockholm_path} --annot_bsml_list ${params.annot_bsml_list} --default_type ${params.default_type} --id_repository ${params.project_id_repository} --gzip_output ${params.compress_bsml_output}
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
    infernal()
    infernal2bsml()
    store_config_params()
    dtd_validation()
}
