#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bmtagger_index
// Generated from Ergatis component JSON by EELS

params {
    bmtool_exec = ''
    input_file = ''
    makeblastdb_exec = ''
    max_ambiguities = ''
    output_directory = ''
    output_label = ''
    srprism_exec = ''
    word_size = ''
}

process Make_index_for_bmfilter {
    script:
    """
    ${params.bmtool_exec} -d ${params.input_file} -o ${params.output_directory}/${params.output_label}.bitmask -A ${params.max_ambiguities} -w ${params.word_size}
    """
}

process Make_index_for_srprism {
    script:
    """
    ${params.srprism_exec} mkindex -i ${params.input_file} -o ${params.output_directory}/${params.output_label}.srprism -M 7168
    """
}

process Make_blastdb_for_BLAST {
    script:
    """
    ${params.makeblastdb_exec} -in ${params.input_file} -dbtype nucl
    """
}

workflow {
    // Serial execution chain
    Make_index_for_bmfilter()
    Make_index_for_srprism()
    Make_blastdb_for_BLAST()
}
