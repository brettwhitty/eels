#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: blast_lgt_finder
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    donor_lineage = ''
    filter_lineage = ''
    filter_min_overlap = ''
    gi2tax = ''
    group_number = ''
    host = ''
    host_lineage = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    mapping_file = ''
    max_overlap = ''
    min_length = ''
    ncbitax = ''
    output_directory = ''
    taxoncoll = ''
    taxondb = ''
    tmp_dir = ''
}

process Filter_BLAST_for_best_hits {
    script:
    """
    ${params.bin_dir}/filter_lgt_best_hit --input_file ${params.i_file_path} --trace_mapping ${params.mapping_file} --host_lineage ${params.host_lineage} --donor_lineage ${params.donor_lineage} --filter_lineage ${params.filter_lineage} --filter_min_overlap ${params.filter_min_overlap} --names_file ${params.ncbitax}/names.dmp --nodes_file ${params.ncbitax}/nodes.dmp --tax_id_file ${params.gi2tax} --host ${params.host} --db ${params.taxondb} --collection ${params.taxoncoll} --tmp_dir ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/ --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.filter.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.filter.stderr
    """
}

process Find_LGT {
    script:
    """
    ${params.bin_dir}/lgt_finder --input_list ${params.output_directory}/${params.iterator_name}/g${params.group_number}/filtered_m8.list --output_prefix ${params.i_file_base} --min_length ${params.min_length} --max_overlap ${params.max_overlap} --ref_lineage ${params.host_lineage} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.lgt_finder.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.lgt_finder.stderr
    """
}

workflow {
    // Serial execution chain
    Filter_BLAST_for_best_hits()
    Find_LGT()
}
