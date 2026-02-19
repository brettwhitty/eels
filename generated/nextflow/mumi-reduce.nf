#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mumi-reduce
// Generated from Ergatis component JSON by EELS

params {
    cluster_threshold = ''
    generate_reduced_db_exec = ''
    input_directory = ''
    input_extension = ''
    mumi_clustering_exec = ''
    mumi_score_aggregator_exec = ''
    output_directory = ''
    tmp_dir = ''
}

process Create_the_toplevel_output_directory_ {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}
    """
}

process Create_a_temporary_working_directory_on_the_scratch_partition_ {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}
    """
}

process Create_a_directory_in_which_to_store_all_final_MUMi_scores_ {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/03_MUMi_scores_and_clusters
    """
}

process Collect_all_pairwise_MUMi_scores_into_a_single_file_ {
    script:
    """
    ${params.mumi_score_aggregator_exec} ${params.output_directory}/02_run_MUMi ${params.output_directory}/03_MUMi_scores_and_clusters/00_pair_scores.txt \
        1>${params.output_directory}/03_MUMi_scores_and_clusters/01_pair_scores__STDOUT.txt \
        2>{{OUTPUT_DIRECTORY}}/03_MUMi_scores_and_clusters/02_pair_scores__STDERR.txt
    """
}

process Transitively_cluster_all_sequence_pairs_S__T_where_MUMi_score_S_T_______CLUSTER_THRESHOLD___ {
    script:
    """
    ${params.mumi_clustering_exec} ${params.cluster_threshold} ${params.output_directory}/03_MUMi_scores_and_clusters/00_pair_scores.txt ${params.output_directory}/03_MUMi_scores_and_clusters/03_clusters.txt \
        1>${params.output_directory}/03_MUMi_scores_and_clusters/04_clusters__STDOUT.txt \
        2>{{OUTPUT_DIRECTORY}}/03_MUMi_scores_and_clusters/05_clusters__STDERR.txt
    """
}

process Pick_a_representative_genome_for_each_cluster__then_concatenate_all_representatives_into_a_single_output_file_ {
    script:
    """
    ${params.generate_reduced_db_exec} ${params.output_directory}/03_MUMi_scores_and_clusters/03_clusters.txt ${params.input_directory} ${params.input_extension} \
        1>${params.output_directory}/03_MUMi_scores_and_clusters/06_buildFinalFile__STDOUT.txt \
        2>{{OUTPUT_DIRECTORY}}/03_MUMi_scores_and_clusters/07_buildFinalFile__STDERR.txt
    """
}

workflow {
    // Serial execution chain
    Create_the_toplevel_output_directory_()
    Create_a_temporary_working_directory_on_the_scratch_partition_()
    Create_a_directory_in_which_to_store_all_final_MUMi_scores_()
    Collect_all_pairwise_MUMi_scores_into_a_single_file_()
    Transitively_cluster_all_sequence_pairs_S__T_where_MUMi_score_S_T_______CLUSTER_THRESHOLD___()
    Pick_a_representative_genome_for_each_cluster__then_concatenate_all_representatives_into_a_single_output_file_()
}
