#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: blast_snp_regions
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    expect = ''
    filter = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    other_opts = ''
    output_directory = ''
    query_list = ''
}

process ncbi_blastn {
    script:
    """
    ${params.bin_dir}/blast_snp_regions --blast_exec /usr/local/bin/blastall --database ${params.i_file_path} --query_list ${params.query_list} --evalue ${params.expect} --filter ${params.filter} --other_args '${params.other_opts}' --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

process parse_raw_BLAST_results {
    script:
    """
    ${params.bin_dir}/parse_snp_blast --input_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --file_extension "raw" --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}
    """
}

workflow {
    // Serial execution chain
    ncbi_blastn()
    parse_raw_BLAST_results()
}
