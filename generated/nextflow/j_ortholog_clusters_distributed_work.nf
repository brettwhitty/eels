#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: j_ortholog_clusters_distributed_work
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    jaccard_cutoff = ''
    jaccard_output_list = ''
    match_bsml_file_list = ''
    max_multi_alignment = ''
    output_directory = ''
    pcoverage_cutoff = ''
    pidentity_cutoff = ''
    pipelineid = ''
    project = ''
    psimilarity_cutoff = ''
    pvalcut = ''
    query_bsml_file_list = ''
    use_feature_ids_in_fasta = ''
}

process parse_bsml_input {
    script:
    """
    ${params.bin_dir}/CogBsmlLoader --bsmlSearchList ${params.match_bsml_file_list} --bsmlModelList ${params.query_bsml_file_list} --bsmlJaccardList '${params.jaccard_output_list}' --outfile ${params.output_directory}/${params.project}.${params.pipelineid}.btab --pvalcut ${params.pvalcut} --coverageCutoff ${params.pcoverage_cutoff} --identityCutoff ${params.pidentity_cutoff} --similarityCutoff ${params.psimilarity_cutoff} \
        1>${params.output_directory}/bsml2cogbtab.stdout \
        2>{{OUTPUT_DIRECTORY}}/bsml2cogbtab.stderr
    """
}

process best_hit {
    script:
    """
    ${params.bin_dir}/best_hit -i ${params.output_directory}/${params.project}.${params.pipelineid}.btab -j ${params.jaccard_cutoff} \
        1>${params.output_directory}/${params.project}.${params.pipelineid}.cog \
        2>{{OUTPUT_DIRECTORY}}/besthit.stderr
    """
}

process cogs2fasta {
    script:
    """
    ${params.bin_dir}/CogProteinFastaNoMap --cogFile ${params.output_directory}/${params.project}.${params.pipelineid}.cog --bsmlModelList ${params.query_bsml_file_list} --outputDir ${params.output_directory} --maxCogSeqCount ${params.max_multi_alignment} --use_feature_ids_in_fasta '${params.use_feature_ids_in_fasta}' \
        1>${params.output_directory}/CogProteinFasta.stdout \
        2>{{OUTPUT_DIRECTORY}}/CogProteinFasta.stderr
    """
}

workflow {
    // Serial execution chain
    parse_bsml_input()
    best_hit()
    cogs2fasta()
}
