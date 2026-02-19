#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: wu-blastn
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
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
    filter = ''
    filter_hsps_for_stats = ''
    group_number = ''
    gspmax = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    other_opts = ''
    output_directory = ''
    pipeline_xml = ''
    tmp_dir = ''
    workflow_repository = ''
}

process wu_blastn {
    script:
    """
    /usr/local/bin/blastn ${params.database_path} ${params.i_file_path} -E ${params.expect} -wordmask ${params.filter} -B ${params.database_matches} -V ${params.descriptions} -gspmax ${params.gspmax} -shortqueryok -novalidctxok ${params.other_opts} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw
    """
}

process convert_raw_to_btab {
    script:
    """
    ${params.bin_dir}/blast2btab --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.btab
    """
}

process convert_raw_to_bsml {
    script:
    """
    ${params.bin_dir}/blast2bsml --query_file_path ${params.i_file_path} --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --pvalue ${params.expect} --filter_hsps_for_stats ${params.filter_hsps_for_stats} --class polypeptide --analysis_id ${params.component_name}_analysis --gzip_output ${params.compress_bsml_output}
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.pipeline_xml} --analysis_id ${params.component_name}_analysis
    """
}

process compress_raw_output {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --compress ${params.compress_raw_output} --list_file ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw.list
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
    wu_blastn()
    convert_raw_to_btab()
    convert_raw_to_bsml()
    store_config_params()
    compress_raw_output()
    dtd_validation()
}
