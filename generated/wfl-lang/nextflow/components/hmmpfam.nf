#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: hmmpfam
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    cutoffs = ''
    database_path = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    hmmpfam_exec = ''
    hmm_info_file = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    model_mol_class = ''
    model_mol_type = ''
    other_opts = ''
    output_directory = ''
    pipeline_xml = ''
    query_mol_class = ''
    query_mol_type = ''
    skip_htab = ''
    workflow_repository = ''
}

process hmmpfam {
    script:
    """
    ${params.hmmpfam_exec} ${params.other_opts} ${params.cutoffs} ${params.database_path} ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw
    """
}

process hmmpfam2htab {
    script:
    """
    ${params.bin_dir}/hmmpfam2htab --donotrun ${params.skip_htab} --input_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw --output_htab ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.htab --mldbm_file '${params.hmm_info_file}' \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

process hmmpfam2bsml {
    script:
    """
    ${params.bin_dir}/hmmpfam2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --fasta_input ${params.i_file_path} --gzip_output ${params.compress_bsml_output} --model_mol_type ${params.model_mol_type} --model_mol_class ${params.model_mol_class} --query_mol_type ${params.query_mol_type} --query_mol_class ${params.query_mol_class}
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
    hmmpfam()
    hmmpfam2htab()
    hmmpfam2bsml()
    store_config_params()
    dtd_validation()
}
