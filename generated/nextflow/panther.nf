#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: panther
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    blastall_exec = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    display_type = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    gunzip_exec = ''
    hmmsearch_exec = ''
    hmm_evalue_cutoff = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    panther_exec = ''
    panther_hmm_library = ''
    pipeline_xml = ''
    tmp_dir = ''
    workflow_repository = ''
}

process panther {
    script:
    """
    ${params.panther_exec} -n -D ${params.display_type} -E ${params.hmm_evalue_cutoff} -B ${params.blastall_exec} -H ${params.hmmsearch_exec} -z ${params.gunzip_exec} -T ${params.tmp_dir} -l ${params.panther_hmm_library} -i ${params.i_file_path} -c 1 \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

process panther2bsml {
    script:
    """
    ${params.bin_dir}/panther2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --query_file_path ${params.i_file_path} --gzip_output ${params.compress_bsml_output}
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
    panther()
    panther2bsml()
    store_config_params()
    dtd_validation()
}
