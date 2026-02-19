#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: core_qiime
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    custom_parameters_file = ''
    fasttree_file_list = ''
    input_file = ''
    mapping_file = ''
    meta_file = ''
    otu_table_list = ''
    output_directory = ''
    reference_fasta = ''
}

process pick_open_reference_otus {
    script:
    """
    ${params.bin_dir}/pick_open_reference_otus  -i ${params.input_file} -p ${params.custom_parameters_file} -f -o ${params.output_directory}/results/uclust_picked_otus -r ${params.reference_fasta} \
        1>${params.tmp_dir}/${params.component_name}.stdout \
        2>{{TMP_DIR}}/{{COMPONENT_NAME}}.stderr
    """
}

process make_otu_heatmap_html_file {
    script:
    """
    ${params.bin_dir}/make_otu_heatmap_html  -i `cat ${params.otu_table_list}` -o ${params.output_directory}/results/otu_heatmap/
    """
}

process create_otu_table_summary_output_directory {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/results/otu_summary_tables
    """
}

process summarizing_taxa_analysis__phyla_ {
    script:
    """
    ${params.bin_dir}/summarize_taxa  -i `cat ${params.otu_table_list}` -o ${params.output_directory}/results/otu_summary_tables -a
    """
}

process reformatting_phyla_assignment_matrix {
    script:
    """
    perl ${params.bin_dir}/Create_Qiime_tables.pl  -t ${params.output_directory}/results/otu_summary_tables/otu_table_mc2_w_tax_no_pynast_failures_L3.txt -m ${params.meta_file} -p ${params.output_directory}/results/otu_summary_tables/phylum
    """
}

process reformatting_classes_assignment_matrix {
    script:
    """
    perl ${params.bin_dir}/Create_Qiime_tables.pl  -t ${params.output_directory}/results/otu_summary_tables/otu_table_mc2_w_tax_no_pynast_failures_L4.txt -m ${params.meta_file} -p ${params.output_directory}/results/otu_summary_tables/class
    """
}

process reformatting_orders_assignment_matrix {
    script:
    """
    perl ${params.bin_dir}/Create_Qiime_tables.pl  -t ${params.output_directory}/results/otu_summary_tables/otu_table_mc2_w_tax_no_pynast_failures_L5.txt -m ${params.meta_file} -p ${params.output_directory}/results/otu_summary_tables/order
    """
}

process reformatting_families_assignment_matrix {
    script:
    """
    perl ${params.bin_dir}/Create_Qiime_tables.pl  -t ${params.output_directory}/results/otu_summary_tables/otu_table_mc2_w_tax_no_pynast_failures_L6.txt -m ${params.meta_file} -p ${params.output_directory}/results/otu_summary_tables/family
    """
}

process summarizing_taxa_analysis__genus_ {
    script:
    """
    ${params.bin_dir}/summarize_taxa  -i `cat ${params.otu_table_list}` -o ${params.output_directory}/results/otu_summary_tables -L 7 -a
    """
}

process reformatting_genera_assignment_matrix {
    script:
    """
    perl ${params.bin_dir}/Create_Qiime_tables.pl  -t ${params.output_directory}/results/otu_summary_tables/otu_table_mc2_w_tax_no_pynast_failures_L7.txt -m ${params.meta_file} -p ${params.output_directory}/results/otu_summary_tables/genus
    """
}

process create_beta_diversity_and_PCoA_plots {
    script:
    """
    ${params.bin_dir}/beta_diversity_through_plots  -i `cat ${params.otu_table_list}` -m ${params.mapping_file} -o ${params.output_directory}/results/beta_diversity/ -p ${params.custom_parameters_file} -t `cat ${params.fasttree_file_list}` -f
    """
}

workflow {
    // Serial execution chain
    pick_open_reference_otus()
    make_otu_heatmap_html_file()
    create_otu_table_summary_output_directory()
    summarizing_taxa_analysis__phyla_()
    reformatting_phyla_assignment_matrix()
    reformatting_classes_assignment_matrix()
    reformatting_orders_assignment_matrix()
    reformatting_families_assignment_matrix()
    summarizing_taxa_analysis__genus_()
    reformatting_genera_assignment_matrix()
    create_beta_diversity_and_PCoA_plots()
}
