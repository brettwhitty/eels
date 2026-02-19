#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: aat_na_masked
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    compress_btab_output = ''
    compress_gap2_output = ''
    database_path = ''
    dds_exec = ''
    dds_opts = ''
    docs_dir = ''
    ergatis_dir = ''
    ext_collapse_exec = ''
    ext_exec = ''
    ext_opts = ''
    filter_exec = ''
    filter_opts = ''
    gap2_database_path = ''
    gap2_exec = ''
    gap2_opts = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_name = ''
    i_file_path = ''
    output_directory = ''
    pipeline_xml = ''
    tmp_dir = ''
    unmasked_fasta_directory = ''
    workflow_repository = ''
}

process dds {
    script:
    """
    ${params.dds_exec} ${params.i_file_path} ${params.database_path} ${params.dds_opts} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.dds.raw \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.dds.stderr
    """
}

process ext {
    script:
    """
    ${params.ext_exec} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.dds.raw ${params.ext_opts} \
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

process gap2 {
    script:
    """
    ${params.gap2_exec} ${params.unmasked_fasta_directory}/${params.i_file_name} ${params.gap2_database_path} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.filter.raw ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.gap2.btab ${params.gap2_opts} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.gap2.raw
    """
}

process remove_raw_dds_output {
    script:
    """
    rm -f ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.dds.raw
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
    touch ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.gap2.btab
    """
}

process gap22bsml {
    script:
    """
    ${params.bin_dir}/gap22bsml --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.gap2.btab --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --query_file_path ${params.i_file_path} --query_id ${params.i_file_base} --gzip_output ${params.compress_bsml_output}
    """
}

process compress_gap2_btab {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.gap2.btab --compress ${params.compress_btab_output}
    """
}

process compress_gap2 {
    script:
    """
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.gap2.raw --compress ${params.compress_gap2_output}
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
    dds()
    ext()
    ext_collapse()
    filter()
    gap2()
    remove_raw_dds_output()
    remove_raw_ext_output()
    remove_raw_ext_collapsed_output()
    remove_raw_filter_output()
    ensure_btab_existence()
    gap22bsml()
    compress_gap2_btab()
    compress_gap2()
    store_config_params()
    dtd_validation()
}
