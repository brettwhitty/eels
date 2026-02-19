#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: tRNAscan-SE
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    id_root = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    other_opts = ''
    output_directory = ''
    pipeline_xml = ''
    project_id_repository = ''
    search_type = ''
    tmp_dir = ''
    trnascanse_exec = ''
    trnascan_lib = ''
    workflow_repository = ''
}

process tRNAscan_SE {
    script:
    """
    export TMPDIR=${params.tmp_dir}; perl -I ${params.trnascan_lib} ${params.trnascanse_exec} -q ${params.other_opts} -b ${params.search_type} ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw \
        2>{{TMP_DIR}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

process tRNAscan_SE2bsml {
    script:
    """
    ${params.bin_dir}/tRNAscan-SE2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --id_repository ${params.project_id_repository} --fasta_input ${params.i_file_path} --project ${params.id_root}
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
    tRNAscan_SE()
    tRNAscan_SE2bsml()
    store_config_params()
    dtd_validation()
}
