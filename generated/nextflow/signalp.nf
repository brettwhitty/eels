#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: signalp
// Generated from Ergatis component JSON by EELS

params {
    args = ''
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_raw_output = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    organism_type = ''
    output_directory = ''
    pipeline_xml = ''
    prediction_method = ''
    project = ''
    project_id_repository = ''
    signalp_exec = ''
    tmp_dir = ''
    truncated_length = ''
    workflow_repository = ''
}

process Create_scratch_dir_for_signalp_output {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}
    """
}

process Run_signalp {
    script:
    """
    ${params.signalp_exec} -t ${params.organism_type} -s '${params.prediction_method}' -c ${params.truncated_length} -T ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} -f summary ${params.args} ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw
    """
}

process Rename_signalp_graphics_files {
    script:
    """
    ${params.bin_dir}/signalp_graphics_rename --input_path ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} --output_path ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --output_prefix ${params.i_file_base}.${params.component_name}
    """
}

process Convert_signalp_raw_output_to_BSML {
    script:
    """
    ${params.bin_dir}/signalp2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --query_file_path ${params.i_file_path} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --project ${params.project} --id_repository ${params.project_id_repository}
    """
}

process store_config_params_for_SignalP_Best {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_best_analysis
    """
}

process store_config_params_for_SignalP_NoTM {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_notm_analysis
    """
}

process store_config_params_for_SignalP_NN {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_nn_analysis
    """
}

process store_config_params_for_SignalP_HMM {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_hmm_analysis
    """
}

process compress_raw_output {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --compress ${params.compress_raw_output} --list_file ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw.list
    """
}

process compress_gnuplot_output {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.gnu --compress ${params.compress_raw_output} --list_file ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.gnu.list
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
    Create_scratch_dir_for_signalp_output()
    Run_signalp()
    Rename_signalp_graphics_files()
    Convert_signalp_raw_output_to_BSML()
    store_config_params_for_SignalP_Best()
    store_config_params_for_SignalP_NoTM()
    store_config_params_for_SignalP_NN()
    store_config_params_for_SignalP_HMM()
    compress_raw_output()
    compress_gnuplot_output()
    dtd_validation()
}
