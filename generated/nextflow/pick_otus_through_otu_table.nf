#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pick_otus_through_otu_table
// Generated from Ergatis component JSON by EELS

params {
    custom_parameters_file = ''
    fasttree_file_list = ''
    input_file_list = ''
    mapping_file = ''
    otu_table_list = ''
    output_directory = ''
    qiime_path = ''
}

process pick_otus_through_otu_table {
    script:
    """
    ${params.qiime_path}/bin/pick_otus_through_otu_table.py  -i `cat ${params.input_file_list}` -p ${params.custom_parameters_file} -o ${params.output_directory}/results \
        1>${params.tmp_dir}/${params.component_name}.stdout \
        2>{{TMP_DIR}}/{{COMPONENT_NAME}}.stderr
    """
}

process make_otu_heatmap_html_file {
    script:
    """
    ${params.qiime_path}/bin/make_otu_heatmap_html.py  -i `cat ${params.otu_table_list}` -o ${params.output_directory}/results/otu_heatmap/
    """
}

process make_otu_network {
    script:
    """
    ${params.qiime_path}/bin/make_otu_network.py  -i `cat ${params.otu_table_list}` -m ${params.mapping_file} -o ${params.output_directory}/results/otu_network/
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
    ${params.qiime_path}/bin/summarize_taxa.py  -i `cat ${params.otu_table_list}` -o ${params.output_directory}/results/otu_summary_tables/otu_table_Level3.txt -L 3 -r 0
    """
}

process summarizing_taxa_analysis__class_ {
    script:
    """
    ${params.qiime_path}/bin/summarize_taxa.py  -i `cat ${params.otu_table_list}` -o ${params.output_directory}/results/otu_summary_tables/otu_table_Level4.txt -L 4 -r 0
    """
}

process summarizing_taxa_analysis__order_ {
    script:
    """
    ${params.qiime_path}/bin/summarize_taxa.py  -i `cat ${params.otu_table_list}` -o ${params.output_directory}/results/otu_summary_tables/otu_table_Level5.txt -L 5 -r 0
    """
}

process summarizing_taxa_analysis__family_ {
    script:
    """
    ${params.qiime_path}/bin/summarize_taxa.py  -i `cat ${params.otu_table_list}` -o ${params.output_directory}/results/otu_summary_tables/otu_table_Level6.txt -L 6 -r 0
    """
}

process summarizing_taxa_analysis__genus_ {
    script:
    """
    ${params.qiime_path}/bin/summarize_taxa.py  -i `cat ${params.otu_table_list}` -o ${params.output_directory}/results/otu_summary_tables/otu_table_Level7.txt -L 7 -r 0
    """
}

process create_alpha_rarefaction_curves {
    script:
    """
    ${params.qiime_path}/bin/alpha_rarefaction.py  -i `cat ${params.otu_table_list}` -m `cat ${params.mapping_file}` -o ${params.output_directory}/results/alpha_rarefaction/ -p ${params.custom_parameters_file} -t `cat ${params.fasttree_file_list}`
    """
}

process create_beta_diversity_and_PCoA_plots {
    script:
    """
    ${params.qiime_path}/bin/beta_diversity_through_3d_plots.py  -i `cat ${params.otu_table_list}` -m `cat ${params.mapping_file}` -o ${params.output_directory}/results/beta_diversity/ -p ${params.custom_parameters_file} -t `cat ${params.fasttree_file_list}`
    """
}

workflow {
    // Serial execution chain
    pick_otus_through_otu_table()
    make_otu_heatmap_html_file()
    make_otu_network()
    create_otu_table_summary_output_directory()
    summarizing_taxa_analysis__phyla_()
    summarizing_taxa_analysis__class_()
    summarizing_taxa_analysis__order_()
    summarizing_taxa_analysis__family_()
    summarizing_taxa_analysis__genus_()
    create_alpha_rarefaction_curves()
    create_beta_diversity_and_PCoA_plots()
}
