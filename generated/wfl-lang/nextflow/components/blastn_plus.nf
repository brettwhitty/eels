#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: blastn_plus
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    blastplus_bin = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    compress_raw_output = ''
    database_path = ''
    docs_dir = ''
    ergatis_dir = ''
    expect = ''
    filter_hsps_for_stats = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    max_target_seqs = ''
    other_opts = ''
    output_directory = ''
    pipelineid = ''
    remote = ''
    repository_root = ''
    split_bsml = ''
    split_btab = ''
    tmp_dir = ''
    workflow_repository = ''
}

process run_blastn_ {
    script:
    """
    ${params.bin_dir}/run_blast_plus --blast_plus_bin ${params.blastplus_bin} --blast_type blastn --query ${params.i_file_path} --db ${params.database_path} --remote ${params.remote} --evalue ${params.expect} --max_target_seqs ${params.max_target_seqs} --out ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --other_opts ${params.other_opts} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

process convert_raw_to_btab {
    script:
    """
    ${params.bin_dir}/blast2btab --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.btab --split ${params.split_btab}
    """
}

process convert_raw_to_bsml {
    script:
    """
    ${params.bin_dir}/blast2bsml --query_file_path ${params.i_file_path} --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --pvalue ${params.expect} --filter_hsps_for_stats ${params.filter_hsps_for_stats} --class polypeptide --analysis_id blastn_analysis --split ${params.split_bsml} --gzip_output ${params.compress_bsml_output}
    """
}

process store_config_params {
    script:
    """
    ${params.bin_dir}/analysis2bsml --ergatis_control_file ${params.ergatis_dir}.ini --conf ${params.component_config} --bsml_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --componenturl ${params.workflow_repository}/component.xml --pipelineurl ${params.repository_root}/workflow/runtime/pipeline/${params.pipelineid}/pipeline.xml --analysis_id blastn_analysis
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
    run_blastn_()
    convert_raw_to_btab()
    convert_raw_to_bsml()
    store_config_params()
    compress_raw_output()
    dtd_validation()
}
