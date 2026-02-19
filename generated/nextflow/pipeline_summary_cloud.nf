#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: pipeline_summary_cloud
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    cds_fasta = ''
    cogs_bsml_list = ''
    cog_lookup = ''
    input_file_list = ''
    locus_prefix = ''
    organism = ''
    other_bsml_lists = ''
    output_directory = ''
    polypeptide_fasta = ''
    sourcename = ''
    translation_table = ''
}

process pipeline_summary {
    script:
    """
    ${params.bin_dir}/pipeline_summary --input_bsml ${params.input_file_list} --output ${params.output_directory} --other_bsml_lists ${params.other_bsml_lists} --locus_prefix ${params.locus_prefix} --cog_search_bsml ${params.cogs_bsml_list} --cog_lookup ${params.cog_lookup} --organism '${params.organism}' --translation_table ${params.translation_table} --cds_fasta ${params.cds_fasta} --polypeptide_fasta ${params.polypeptide_fasta} --sourcename ${params.sourcename}
    """
}

process sync_staging_directory {
    script:
    """
    /opt/vappio-scripts/syncdata.sh --synchronous
    """
}

workflow {
    // Serial execution chain
    pipeline_summary()
    sync_staging_directory()
}
