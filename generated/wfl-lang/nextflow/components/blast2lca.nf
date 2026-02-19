#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: blast2lca
// Generated from Ergatis component JSON by EELS

params {
    best_blast_hit = ''
    bin_dir = ''
    evalue_cutoff = ''
    gi2tax = ''
    group_number = ''
    host = ''
    iterator_name = ''
    i_file_path = ''
    ncbitax = ''
    output_directory = ''
    taxoncoll = ''
    taxondb = ''
    tmp_dir = ''
}

process Get_lowest_common_ancestor_from_blast_hits {
    script:
    """
    ${params.bin_dir}/blast2lca --input_file ${params.i_file_path} --tax_id_file ${params.gi2tax} --names_file ${params.ncbitax}/names.dmp --nodes_file ${params.ncbitax}/nodes.dmp --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --tmp_dir ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/ --db ${params.taxondb} --host ${params.host} --collection ${params.taxoncoll} --evalue_cutoff ${params.evalue_cutoff} --best_hits_only ${params.best_blast_hit} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/blast2lca.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/blast2lca.stderr
    """
}

workflow {
    // Serial execution chain
    Get_lowest_common_ancestor_from_blast_hits()
}
