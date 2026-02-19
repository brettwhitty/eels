#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: cluster_mapping
// Generated from Ergatis component JSON by EELS

params {
    analysis_id1 = ''
    analysis_id2 = ''
    bin_dir = ''
    database = ''
    output_directory = ''
    password = ''
    rdbms = ''
    report_file = ''
    server = ''
    tmp_dir = ''
    username = ''
}

process create_output_directories {
    script:
    """
    mkdir -p -m 777 ${params.output_directory} ${params.tmp_dir}
    """
}

process Generate_mapping_between_clusters_for_analysis_id1____ANALYSIS_ID1____and_analysis_id2____ANALYSIS_ID2____on_database____DATABASE____server____SERVER___ {
    script:
    """
    ${params.bin_dir}/mapClusters --username ${params.username} --password ${params.password} --database ${params.database} --server ${params.server} --vendor ${params.rdbms} --analysis_id1 ${params.analysis_id1} --analysis_id2 ${params.analysis_id2} --outfile ${params.report_file} \
        1>${params.tmp_dir}/mapClusters.pl.stdout \
        2>{{TMP_DIR}}/mapClusters.pl.stderr
    """
}

workflow {
    // Serial execution chain
    create_output_directories()
    Generate_mapping_between_clusters_for_analysis_id1____ANALYSIS_ID1____and_analysis_id2____ANALYSIS_ID2____on_database____DATABASE____server____SERVER___()
}
