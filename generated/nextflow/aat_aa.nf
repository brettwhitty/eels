#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: aat_aa
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    compress_btab_output = ''
    compress_nap_output = ''
    cutoff_identity = ''
    cutoff_similarity = ''
    database_path = ''
    database_path_for_nap = ''
    docs_dir = ''
    dps_exec = ''
    dps_opts = ''
    ergatis_dir = ''
    ext_collapse_exec = ''
    ext_exec = ''
    ext_opts = ''
    filter_exec = ''
    filter_opts = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    matrix = ''
    nap_exec = ''
    nap_opts = ''
    output_directory = ''
    pipeline_xml = ''
    tmp_dir = ''
    workflow_repository = ''
}

process dps {
    script:
    """
    ${params.dps_exec} ${params.i_file_path} ${params.database_path} ${params.matrix} ${params.dps_opts} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.dps.raw
    """
}

process ext {
    script:
    """
    ${params.ext_exec} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.dps.raw ${params.ext_opts} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.ext.raw
    """
}

process ext_collapse {
    script:
    """
    ${params.ext_collapse_exec} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.ext.raw \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.ext.collapsed
    """
}

process filter {
    script:
    """
    ${params.filter_exec} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.ext.collapsed ${params.filter_opts} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.filter.raw
    """
}

process relocate_query_seq {
    script:
    """
    cp ${params.i_file_path} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}
    """
}

process nap {
    script:
    """
    ${params.nap_exec} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base} ${params.database_path_for_nap} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.filter.raw ${params.matrix} ${params.nap_opts} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.nap.raw
    """
}

process remove_temp_query_seq {
    script:
    """
    rm -f ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}
    """
}

process remove_raw_dps_output {
    script:
    """
    rm -f ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.dps.raw
    """
}

process remove_raw_ext_output {
    script:
    """
    rm -f ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.ext.raw
    """
}

process remove_raw_ext_collapsed_output {
    script:
    """
    rm -f ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.ext.collapsed
    """
}

process remove_raw_filter_output {
    script:
    """
    rm -f ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.filter.raw
    """
}

process ensure_btab_existence {
    script:
    """
    touch ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.nap.btab
    """
}

process relocate_btab {
    script:
    """
    mv ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.nap.btab ${params.output_directory}/${params.iterator_name}/g${params.group_number}
    """
}

process nap2bsml {
    script:
    """
    ${params.bin_dir}/nap2bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.nap.btab --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --query_file_path ${params.i_file_path} --query_id ${params.i_file_base} --gzip_output ${params.compress_bsml_output} --cutoff_identity '${params.cutoff_identity}' --cutoff_similarity '${params.cutoff_similarity}'
    """
}

process compress_nap_btab {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.nap.btab --compress ${params.compress_btab_output}
    """
}

process compress_nap {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.nap.raw --compress ${params.compress_nap_output}
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
    dps()
    ext()
    ext_collapse()
    filter()
    relocate_query_seq()
    nap()
    remove_temp_query_seq()
    remove_raw_dps_output()
    remove_raw_ext_output()
    remove_raw_ext_collapsed_output()
    remove_raw_filter_output()
    ensure_btab_existence()
    relocate_btab()
    nap2bsml()
    compress_nap_btab()
    compress_nap()
    store_config_params()
    dtd_validation()
}
