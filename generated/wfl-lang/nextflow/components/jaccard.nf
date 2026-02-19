#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: jaccard
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    cluster_path = ''
    group_number = ''
    iterator_name = ''
    i_genome = ''
    i_genome_list_file = ''
    linkscore = ''
    match_bsml_file_list = ''
    max_multi_alignment = ''
    output_directory = ''
    pcoverage_cutoff = ''
    pidentity_cutoff = ''
    psimilarity_cutoff = ''
    pvalcut = ''
    use_feature_ids_in_fasta = ''
}

process make_asmbl_lookup {
    script:
    """
    ${params.bin_dir}/bsml2idlookup --bsml_list ${params.i_genome_list_file} --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_genome}.asmbl.lookup
    """
}

process generate_clusters {
    script:
    """
    ${params.bin_dir}/clusterBsmlPairwiseAlignments --bsmlSearchList ${params.match_bsml_file_list} --asmbl_lookup ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_genome}.asmbl.lookup --log ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_genome}.cluster.log --linkscore ${params.linkscore} --percent_identity ${params.pidentity_cutoff} --percent_similarity ${params.psimilarity_cutoff} --percent_coverage ${params.pcoverage_cutoff} --p_value ${params.pvalcut} --outfile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_genome}.jkcluster.out --cluster_path ${params.cluster_path}
    """
}

process jaccard2fasta {
    script:
    """
    ${params.bin_dir}/CogProteinFastaNoMap --cogFile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_genome}.jkcluster.out --bsmlModelList ${params.i_genome_list_file} --outputDir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_genome} --maxCogSeqCount ${params.max_multi_alignment} --use_feature_ids_in_fasta '${params.use_feature_ids_in_fasta}' --outputToken ${params.group_number}
    """
}

process create_fasta_list {
    script:
    """
    find ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_genome} -name '*.fsa' \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_genome}.${params.component_name}.fsa.list
    """
}

workflow {
    // Serial execution chain
    make_asmbl_lookup()
    generate_clusters()
    jaccard2fasta()
    create_fasta_list()
}
