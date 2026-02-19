#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bepipred
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
    leave_fasta_headers = ''
    output_directory = ''
    pipeline_xml = ''
    project = ''
    project_id_repository = ''
    threshold = ''
    workflow_repository = ''
}

process replace_fasta_headers {
    script:
    """
    ${params.bin_dir}/replace_fasta_headers.pl --input ${params.i_file_path} --map_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.map --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fixed.fsa --do_nothing ${params.leave_fasta_headers}
    """
}

process bepipred {
    script:
    """
    /local/projects/STREP/bepipred-1.0b/bepipred -t ${params.threshold} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fixed.fsa \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw \
        2>{{TMP_DIR}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

process fix_output_file {
    script:
    """
    ${params.bin_dir}/replace_fasta_headers.pl --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --map_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.map --do_nothing ${params.leave_fasta_headers} --replace 1
    """
}

process bepipred2bsml {
    script:
    """
    ${params.bin_dir}/bepipred2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --project ${params.project} --fasta_input ${params.i_file_path} --compress_bsml_output ${params.compress_bsml_output} --id_repository ${params.project_id_repository}
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
    replace_fasta_headers()
    bepipred()
    fix_output_file()
    bepipred2bsml()
    store_config_params()
    dtd_validation()
}
