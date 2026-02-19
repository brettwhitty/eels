#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fuzznuc
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    complement_search = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    docs_dir = ''
    ergatis_dir = ''
    fuzznuc_exec = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    pattern = ''
    pattern_name = ''
    pipeline_xml = ''
    workflow_repository = ''
}

process fuzznuc {
    script:
    """
    ${params.fuzznuc_exec} -rformat2 srs -rscoreshow2 1 -pname ${params.pattern_name} -sequence ${params.i_file_path} -pattern ${params.pattern} -complement ${params.complement_search} -outfile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw
    """
}

process fuzznuc2bsml {
    script:
    """
    ${params.bin_dir}/fuzznuc2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --fasta_input ${params.i_file_path} --gzip_output ${params.compress_bsml_output}
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
    fuzznuc()
    fuzznuc2bsml()
    store_config_params()
    dtd_validation()
}
