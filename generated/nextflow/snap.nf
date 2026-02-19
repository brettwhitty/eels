#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: snap
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_raw_output = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    hmm_file = ''
    input_seq_class = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    other_opts = ''
    output_directory = ''
    pipeline_xml = ''
    project = ''
    project_id_repository = ''
    snap_exec = ''
    tmp_dir = ''
    workflow_repository = ''
}

process snap {
    script:
    """
    ${params.snap_exec} ${params.hmm_file} ${params.i_file_path} ${params.other_opts} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw
    """
}

process snap2bsml {
    script:
    """
    ${params.bin_dir}/snap2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --fasta_file ${params.i_file_path} --project ${params.project} --seq_class ${params.input_seq_class} --id_repo ${params.project_id_repository}
    """
}

process compress_raw_output {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --compress ${params.compress_raw_output} --list_file ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw.list
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
    snap()
    snap2bsml()
    compress_raw_output()
    store_config_params()
    dtd_validation()
}
