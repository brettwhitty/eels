#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: ps_scan
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
    other_opts = ''
    output_directory = ''
    pfscan_exec = ''
    pipeline_xml = ''
    prosite_dat = ''
    psa2msa_exec = ''
    ps_scan_exec = ''
    workflow_repository = ''
}

process ps_scan {
    script:
    """
    ${params.ps_scan_exec} ${params.other_opts} -d '${params.prosite_dat}' ${params.i_file_path} --pfscan ${params.pfscan_exec} --psa2msa ${params.psa2msa_exec} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw
    """
}

process ps_scan2bsml {
    script:
    """
    ${params.bin_dir}/ps_scan2bsml --input_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --analysis_id ${params.component_name}_analysis --gzip_output ${params.compress_bsml_output} --query_file_path ${params.i_file_path}
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
    ps_scan()
    ps_scan2bsml()
    store_config_params()
    dtd_validation()
}
