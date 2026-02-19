#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mugsyalign
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    id_map_file = ''
    output_directory = ''
    output_prefix = ''
}

process Replace_organism_ids_in_maf {
    script:
    """
    ${params.bin_dir}/replace_maf_ids --id_file ${params.id_map_file} --maf ${params.output_directory}/${params.output_prefix}.maf --output_file ${params.output_directory}/${params.output_prefix}.maf.tmp \
        1>${params.workflow_repository}/replace_maf_ids.stdout \
        2>{{WORKFLOW_REPOSITORY}}/replace_maf_ids.stderr
    """
}

process Move_file {
    script:
    """
    /bin/mv ${params.output_directory}/${params.output_prefix}.maf.tmp ${params.output_directory}/${params.output_prefix}.maf
    """
}

workflow {
    // Serial execution chain
    Replace_organism_ids_in_maf()
    Move_file()
}
