#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: RAPSearch2
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    btab_sqlite_db = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    compress_raw_output = ''
    database_matches = ''
    database_path = ''
    descriptions = ''
    docs_dir = ''
    ergatis_dir = ''
    expect = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    min_aln_length = ''
    other_opts = ''
    output_directory = ''
    pipelineid = ''
    rapsearch_exec = ''
    repository_root = ''
    tmp_dir = ''
    workflow_repository = ''
}

process RAPSearch2 {
    script:
    """
    ${params.rapsearch_exec}  -q ${params.i_file_path} -d ${params.database_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name} -s F -e ${params.expect} -l ${params.min_aln_length} -b ${params.database_matches} -v ${params.descriptions} ${params.other_opts}
    """
}

process convert_m8_to_btab {
    script:
    """
    ${params.bin_dir}/RAPSearch2btab --input_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.m8 --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.btab --uniprot_db ${params.btab_sqlite_db}
    """
}

process convert_btab_to_bsml {
    script:
    """
    ${params.bin_dir}/blastbtab2bsml --query_file_path ${params.i_file_path} --btab_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.btab --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --pvalue ${params.expect} --class polypeptide --analysis_id ${params.component_name}_analysis --gzip ${params.compress_bsml_output}
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.repository_root}/workflow/runtime/pipeline/${params.pipelineid}/pipeline.xml --analysis_id ${params.component_name}_analysis
    """
}

process compress_m8_output {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.m8 --compress ${params.compress_raw_output} --list_file ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.m8.list
    """
}

process compress_aln_output {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.aln --compress ${params.compress_raw_output} --list_file ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.aln.list
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
    RAPSearch2()
    convert_m8_to_btab()
    convert_btab_to_bsml()
    store_config_params()
    compress_m8_output()
    compress_aln_output()
    dtd_validation()
}
