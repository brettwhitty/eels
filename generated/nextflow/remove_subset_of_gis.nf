#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: remove_subset_of_gis
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database = ''
    input_file = ''
    output_directory = ''
    taxon_id = ''
}

process fetch_GIs_of_taxon_ID {
    script:
    """
    ${params.bin_dir}/fetch_gis_from_taxon_id --database ${params.database} --taxon_id ${params.taxon_id} --output_dir ${params.output_directory}
    """
}

process sort_large_GI_list {
    script:
    """
    sort -n ${params.input_file} \
        1>${params.output_directory}/sorted_superset.gilist
    """
}

process sort_small_GI_list {
    script:
    """
    sort -n ${params.output_directory}/${params.taxon_id}.gilist \
        1>${params.output_directory}/sorted_subset.gilist
    """
}

process Suppress_subset_of_GI {
    script:
    """
    comm -2 -3 ${params.output_directory}/sorted_superset.gilist ${params.output_directory}/sorted_subset.gilist \
        1>${params.output_directory}/gis_without_${params.taxon_id}.gilist
    """
}

workflow {
    // Serial execution chain
    fetch_GIs_of_taxon_ID()
    sort_large_GI_list()
    sort_small_GI_list()
    Suppress_subset_of_GI()
}
