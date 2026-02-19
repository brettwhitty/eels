#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: ber
// Generated from Ergatis component JSON by EELS

params {
    additional_blast_hits_list = ''
    additional_minidb_fasta = ''
    bin_dir = ''
    bp_offset = ''
    cdbfasta_path = ''
    component_config = ''
    component_name = ''
    compress_bsml_output = ''
    compress_raw_output = ''
    docs_dir = ''
    ergatis_dir = ''
    formatdb_path = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    max_e_value = ''
    max_num_hits = ''
    max_num_hits_per_region = ''
    max_p_value = ''
    min_num_experimental = ''
    nucleotide_db = ''
    nucleotide_db_format = ''
    output_directory = ''
    pipeline_xml = ''
    praze_exec = ''
    project_abbreviation = ''
    project_id_repository = ''
    protein_db = ''
    protein_db_format = ''
    protein_nucleotide_id_map = ''
    tmp_dir = ''
    workflow_repository = ''
    xdformat_path = ''
}

process filter_hits {
    script:
    """
    ${params.bin_dir}/ber_blast_hit_selector -i ${params.i_file_path} -o ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.filtered.btab.tmp -e ${params.max_e_value} -E ${params.max_p_value} -n ${params.max_num_hits} -N ${params.max_num_hits_per_region} -V ${params.min_num_experimental}
    """
}

process filter_additional_hits {
    script:
    """
    ${params.bin_dir}/extract_blast_hits_by_id -I $(cut -f1 ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.filtered.btab.tmp) --input_list '${params.additional_blast_hits_list}' --output ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.filtered.extra.btab
    """
}

process append_to_filtered_hits {
    script:
    """
    cat ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.filtered.btab.tmp ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.filtered.extra.btab \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.filtered.btab
    """
}

process create_mini_db {
    script:
    """
    ${params.bin_dir}/create_ber_db.sh -b ${params.bin_dir} -i ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.filtered.btab -o ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.minidb.tmp -d ${params.protein_db} -f ${params.protein_db_format} -p -c '${params.cdbfasta_path}' -a '${params.formatdb_path}' -x '${params.xdformat_path}'
    """
}

process append_to_mini_db {
    script:
    """
    cat ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.minidb.tmp ${params.additional_minidb_fasta} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.minidb
    """
}

process create_nuc_db {
    script:
    """
    ${params.bin_dir}/create_ber_db.sh -b ${params.bin_dir} -i ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.filtered.btab -o ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.nuc -d ${params.nucleotide_db} -f ${params.nucleotide_db_format} -m ${params.protein_nucleotide_id_map} -c '${params.cdbfasta_path}' -a '${params.formatdb_path}' -x '${params.xdformat_path}'
    """
}

process praze {
    script:
    """
    ${params.praze_exec} -O ${params.i_file_base}.${params.component_name} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.nuc ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.minidb
    """
}

process fix_praze_output {
    script:
    """
    ${params.bin_dir}/add_pvalue_to_praze_output -b ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.filtered.btab -p ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.nr.btab -m ${params.protein_nucleotide_id_map} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.nr.btab.tmp
    """
}

process rename_fixed_praze_output {
    script:
    """
    mv ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.nr.btab.tmp ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.nr.btab
    """
}

process berbtab2bsml {
    script:
    """
    ${params.bin_dir}/berbtab2bsml --btab_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.nr.btab --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.bsml --pvalue ${params.max_p_value} --class CDS --analysis_id ${params.component_name}_analysis --mapping_file ${params.protein_nucleotide_id_map} --bp_offset ${params.bp_offset} --gzip_output ${params.compress_bsml_output} --id_repository ${params.project_id_repository} --project_abbreviation ${params.project_abbreviation}
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
    ${params.bin_dir}/compress_file --file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.nr --compress ${params.compress_raw_output} --list_file ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw.list
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
    filter_hits()
    filter_additional_hits()
    append_to_filtered_hits()
    create_mini_db()
    append_to_mini_db()
    create_nuc_db()
    praze()
    fix_praze_output()
    rename_fixed_praze_output()
    berbtab2bsml()
    store_config_params()
    compress_raw_output()
    dtd_validation()
}
