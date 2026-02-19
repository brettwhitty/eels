#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mumsgraph
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    coverage_cutoff = ''
    docs_dir = ''
    mummertab_file_list = ''
    output_directory = ''
    reference_fasta = ''
}

process mummer {
    script:
    """
    ${params.bin_dir}/fasta2seqlen stdin ${params.reference_fasta} \
        1>${params.output_directory}/${params.component_name}.seqlens.out
    """
}

process sort_seqlens {
    script:
    """
    sort stdin ${params.output_directory}/${params.component_name}.seqlens.out \
        1>${params.output_directory}/${params.component_name}.seqlens.out.sorted
    """
}

process filter_on_query_coverage {
    script:
    """
    ${params.bin_dir}/filtermummer --query ${params.coverage_cutoff} stdin ${params.mummertab_file_list} \
        1>${params.output_directory}/${params.component_name}.mummertab.out
    """
}

process sort_mummertab {
    script:
    """
    sort stdin ${params.output_directory}/${params.component_name}.mummertab.out \
        1>${params.output_directory}/${params.component_name}.mummertab.out.sorted
    """
}

process join_tab {
    script:
    """
    join  -j 1 ${params.output_directory}/${params.component_name}.mummertab.out.sorted ${params.output_directory}/${params.component_name}.seqlens.out.sorted \
        1>${params.output_directory}/${params.component_name}.joined.out
    """
}

process create_list {
    script:
    """
    echo ${params.output_directory}/${params.component_name}.joined.out \
        1>${params.output_directory}/${params.component_name}.joined.out.list
    """
}

process filter_on_query_coverage {
    script:
    """
    ${params.bin_dir}/filtermummer --reference ${params.coverage_cutoff} stdin ${params.output_directory}/${params.component_name}.joined.out.list \
        1>${params.output_directory}/${params.component_name}.joined.out.filt
    """
}

process print_match_graph {
    script:
    """
    ${params.bin_dir}/printmatchgraph stdin ${params.output_directory}/${params.component_name}.joined.out.filt \
        1>${params.output_directory}/${params.component_name}.out.graph
    """
}

process find_connected_components {
    script:
    """
    ${params.bin_dir}/runcc ${params.output_directory}/${params.component_name}.out.graph \
        1>${params.output_directory}/${params.component_name}.out.graph.cc
    """
}

process print_components {
    script:
    """
    gvpr -f ${params.docs_dir}/printgraph.g stdin ${params.output_directory}/${params.component_name}.out.graph.cc \
        1>${params.output_directory}/${params.component_name}.out.clusters
    """
}

process sort_clusters {
    script:
    """
    sort -k 1,1 -k 3,3 -n -r  stdin ${params.output_directory}/${params.component_name}.out.clusters \
        1>${params.output_directory}/${params.component_name}.out.clusters.sorted
    """
}

process print_reps {
    script:
    """
    ${params.bin_dir}/printrepresentative ${params.output_directory}/${params.component_name}.cluster.fasta ${params.reference_fasta} ${params.coverage_cutoff} stdin ${params.output_directory}/${params.component_name}.out.clusters.sorted \
        1>${params.output_directory}/${params.component_name}.cluster.id.lookup
    """
}

workflow {
    // Serial execution chain
    mummer()
    sort_seqlens()
    filter_on_query_coverage()
    sort_mummertab()
    join_tab()
    create_list()
    filter_on_query_coverage()
    print_match_graph()
    find_connected_components()
    print_components()
    sort_clusters()
    print_reps()
}
