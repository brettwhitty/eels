#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: geneid
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    compress_gff3_output = ''
    docs_dir = ''
    ergatis_dir = ''
    geneid_exec = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    other_opts = ''
    output_directory = ''
    param_file = ''
    pipeline_xml = ''
    project = ''
    project_id_repository = ''
    tmp_dir = ''
    workflow_repository = ''
}

process geneid {
    script:
    """
    ${params.geneid_exec} -P ${params.param_file} ${params.i_file_path} ${params.other_opts} -3 \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.gff3
    """
}

process geneidgff32bsml {
    script:
    """
    ${params.bin_dir}/geneidgff32bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.gff3 --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --project ${params.project} --id_repository ${params.project_id_repository}
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_analysis
    """
}

process compress_bsml_output {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --compress ${params.compress_bsml_output} --list_file ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml.list
    """
}

process compress_gff3_output {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.gff3 --compress ${params.compress_gff3_output} --list_file ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.gff3.list
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
    geneid()
    geneidgff32bsml()
    store_config_params()
    compress_bsml_output()
    compress_gff3_output()
    dtd_validation()
}
