#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: hmmls
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    database_path = ''
    docs_dir = ''
    ergatis_dir = ''
    group_number = ''
    hmmls_exec = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    leave_fasta_headers = ''
    model_mol_class = ''
    model_mol_type = ''
    model_name = ''
    other_opts = ''
    output_directory = ''
    pipeline_xml = ''
    query_mol_class = ''
    query_mol_type = ''
    search_window = ''
    threshold_cutoff = ''
    workflow_repository = ''
}

process replace_fasta_headers {
    script:
    """
    ${params.bin_dir}/replace_fasta_headers.pl --input ${params.i_file_path} --map_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.map --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fixed.fsa --do_nothing ${params.leave_fasta_headers}
    """
}

process hmmls {
    script:
    """
    ${params.hmmls_exec} -w ${params.search_window} -t ${params.threshold_cutoff} ${params.other_opts} ${params.database_path} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.fixed.fsa \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw
    """
}

process fix_output_file {
    script:
    """
    ${params.bin_dir}/replace_fasta_headers.pl --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw --map_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.map --do_nothing ${params.leave_fasta_headers} --replace 1
    """
}

process hmmls2bsml {
    script:
    """
    ${params.bin_dir}/hmmls2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml --fasta_input ${params.i_file_path} --gzip_output ${params.compress_bsml_output} --model_mol_type ${params.model_mol_type} --model_name ${params.model_name} --model_mol_class ${params.model_mol_class} --query_mol_type ${params.query_mol_type} --query_mol_class ${params.query_mol_class}
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
    replace_fasta_headers()
    hmmls()
    fix_output_file()
    hmmls2bsml()
    store_config_params()
    dtd_validation()
}
