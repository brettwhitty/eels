#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: trf
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    delta = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    match = ''
    maxperiod = ''
    minscore = ''
    mismatch = ''
    other_opts = ''
    output_directory = ''
    pi = ''
    pipeline_xml = ''
    pm = ''
    project = ''
    project_id_repository = ''
    tmp_dir = ''
    trf_exec = ''
    workflow_repository = ''
}

process trf {
    script:
    """
    ${params.bin_dir}/trf_wrapper --trf_exec ${params.trf_exec} --input ${params.i_file_path} --match ${params.match} --mismatch ${params.mismatch} --delta ${params.delta} --pm ${params.pm} --pi ${params.pi} --minscore ${params.minscore} --maxperiod ${params.maxperiod} --other_opts '-d ${params.other_opts}' --output_dir ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}
    """
}

process relocate_output {
    script:
    """
    find ${params.tmp_dir}/${params.iterator_name}/g${params.group_number} -type f -regex '.*\/${params.i_file_base}\..*${params.match}\.${params.mismatch}\.${params.delta}\.${params.pm}\.${params.pi}\.${params.minscore}\.${params.maxperiod}\.dat' -exec mv \{\} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw \;
    """
}

process trf2bsml {
    script:
    """
    ${params.bin_dir}/trf2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --project ${params.project} --id_repository ${params.project_id_repository} --gzip_output ${params.compress_bsml_output} --fasta_input ${params.i_file_path}
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
    trf()
    relocate_output()
    trf2bsml()
    store_config_params()
    dtd_validation()
}
