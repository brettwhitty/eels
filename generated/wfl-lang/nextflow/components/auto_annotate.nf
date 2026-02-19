#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: auto_annotate
// Generated from Ergatis component JSON by EELS

params {
    ber_analysis = ''
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    hmm_analysis = ''
    hmm_info_db = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    length_cutoff = ''
    output_directory = ''
    panda_header_file = ''
    panda_header_offsets = ''
    pipeline_xml = ''
    role_info_db = ''
    workflow_repository = ''
}

process auto_annotate_compute {
    script:
    """
    ${params.bin_dir}/auto_annotate --input_file ${params.i_file_path} --hmm_analysis ${params.hmm_analysis} --ber_analysis ${params.ber_analysis} --hmm_info_db ${params.hmm_info_db} --panda_header_offsets ${params.panda_header_offsets} --length_cutoff ${params.length_cutoff} --panda_header_file ${params.panda_header_file} --role_info_db ${params.role_info_db} --gzip_output ${params.compress_bsml_output} --output_bsml ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml \
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
    auto_annotate_compute()
    store_config_params()
    dtd_validation()
}
