#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: metagene
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    cutoff = ''
    gene_prefix = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    metagene_exec = ''
    num_seqs = ''
    output_directory = ''
    out_format = ''
    project = ''
    project_id_repository = ''
}

process metagene {
    script:
    """
    ${params.metagene_exec} ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw
    """
}

process metagene2bsml {
    script:
    """
    ${params.bin_dir}/metagene2bsml --num_seqs ${params.num_seqs} --cutoff ${params.cutoff} --fasta_input ${params.i_file_path} --input_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.i_file_base}.${params.component_name} --output_directory ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --project ${params.project} --id_repository ${params.project_id_repository}
    """
}

process get_seq_by_metagene {
    script:
    """
    ${params.bin_dir}/get_seq_by_metagene --fasta_input ${params.i_file_path} --input_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.gbk --format ${params.out_format} --prefix ${params.gene_prefix}
    """
}

workflow {
    // Serial execution chain
    metagene()
    metagene2bsml()
    get_seq_by_metagene()
}
