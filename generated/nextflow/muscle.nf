#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: muscle
// Generated from Ergatis component JSON by EELS

params {
    analysis_conf = ''
    bin_dir = ''
    component_name = ''
    compress_raw_output = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_name = ''
    i_file_path = ''
    muscle_exec = ''
    other_opts = ''
    output_directory = ''
    output_flag = ''
    pipeline_xml = ''
    workflow_repository = ''
}

process relocate_query_file {
    script:
    """
    cp ${params.i_file_path} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/
    """
}

process muscle {
    script:
    """
    ${params.muscle_exec} ${params.output_flag} ${params.other_opts} -in ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_name} -out ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.clw -tree1 ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.tree1.phy -tree2 ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.tree2.phy
    """
}

process validate_muscle_output {
    script:
    """
    ${params.bin_dir}/validate_clustalw_output -fastafile ${params.i_file_path} -clwfile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.clw
    """
}

process msf2bsml {
    script:
    """
    ${params.bin_dir}/MSF2Bsml --msffile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.clw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --analysis_conf '${params.analysis_conf}' --dnd_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.tree1.phy --fastafile ${params.i_file_path}
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.analysis_conf} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id first
    """
}

process compress_raw_output {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.clw --compress ${params.compress_raw_output} --list_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.clw.list
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
    relocate_query_file()
    muscle()
    validate_muscle_output()
    msf2bsml()
    store_config_params()
    compress_raw_output()
    dtd_validation()
}
