#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mugsycog
// Generated from Ergatis component JSON by EELS

params {
    mugsy_map_file = ''
}

process Fix_mugsy_map_file {
    script:
    """
    awk '$3!="-" && $4!="-" && $5!="-" && $6!="-" && $7!="-"' ${params.mugsy_map_file} \
        1>${params.mugsy_map_file}.tmp
    """
}

process Move_mugsy_map_file {
    script:
    """
    /bin/mv ${params.mugsy_map_file}.tmp ${params.mugsy_map_file}
    """
}

workflow {
    // Serial execution chain
    Fix_mugsy_map_file()
    Move_mugsy_map_file()
}
