#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: make_comparative_circleator_figure
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    circleator_path = ''
    genbank_list = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    output_format = ''
    output_height = ''
    output_width = ''
    rasterizer_path = ''
    snp_file = ''
}

process remove_non_unique_snps {
    script:
    """
    ${params.bin_dir}/remove_nonunique_snps --snp_file ${params.snp_file} --reference ${params.i_file_base} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}_filtered_snps.txt \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}_rm_nonuniq_snps.stderr
    """
}

process make_comparative_circleator_figure {
    script:
    """
    ${params.bin_dir}/make_comparative_circleator_figure --circleator_path ${params.circleator_path} --rasterizer_path ${params.rasterizer_path} --gb_list_file ${params.genbank_list} --gene_summary_file ${params.i_file_path} --snp_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}_filtered_snps.txt --svg_file ${params.i_file_base} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --output_formats ${params.output_format} --output_width ${params.output_width} --output_height ${params.output_height} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    remove_non_unique_snps()
    make_comparative_circleator_figure()
}
