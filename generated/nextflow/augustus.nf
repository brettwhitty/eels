#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: augustus
// Generated from Ergatis component JSON by EELS

params {
    augustus_binary_path = ''
    augustus_config_path = ''
    bin_dir = ''
    cds = ''
    component_config = ''
    component_name = ''
    docs_dir = ''
    ergatis_dir = ''
    extrinsic_config_file = ''
    genemodel = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    other_opts = ''
    output_directory = ''
    pipeline_xml = ''
    project = ''
    project_id_repository = ''
    species = ''
    split_size = ''
    strand = ''
    workflow_repository = ''
}

process augustus {
    script:
    """
    ${params.augustus_binary_path} ${params.i_file_path} ${params.other_opts} --maxDNAPieceSize ${params.split_size} --species ${params.species} --cds ${params.cds} --strand ${params.strand} --genemodel ${params.genemodel} --AUGUSTUS_CONFIG_PATH ${params.augustus_config_path} --extrinsicCfgFile ${params.extrinsic_config_file} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw
    """
}

process augustus2bsml {
    script:
    """
    ${params.bin_dir}/augustus2bsml --input_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --fasta_input ${params.i_file_path} --project ${params.project} --sourcename ${params.output_directory}/dummy/dir --id_repository ${params.project_id_repository}
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
    augustus()
    augustus2bsml()
    store_config_params()
    dtd_validation()
}
