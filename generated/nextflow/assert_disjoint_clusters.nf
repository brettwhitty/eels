#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: assert_disjoint_clusters
// Generated from Ergatis component JSON by EELS

params {
    analysis_id = ''
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

process assert_the_clusters_for_analysis_id____ANALYSIS_ID____are_disjoint {
    script:
    """
    ${params.bin_dir}/assertClustersDisjoint --username ${params.username} --password ${params.password} --database ${params.database} --server ${params.server} --vendor ${params.rdbms} --analysis_id ${params.analysis_id} --outfile ${params.report_file} \
        1>${params.tmp_dir}/assert_disjoint_clusters.pl.stdout \
        2>{{TMP_DIR}}/assert_disjoint_clusters.pl.stderr
    """
}

workflow {
    // Serial execution chain
    create_output_directories()
    assert_the_clusters_for_analysis_id____ANALYSIS_ID____are_disjoint()
}
