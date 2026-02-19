#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: basic_alignment_stats
// Generated from Ergatis component JSON by EELS

params {
    i_file_path = ''
    samtools_exec = ''
}

process samtools_idxstats {
    script:
    """
    ${params.samtools_exec} idxstats ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.idxstats.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.idxstats.stderr
    """
}

process samtools_flagstat {
    script:
    """
    ${params.samtools_exec} flagstat ${params.i_file_path} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.flagstat.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.flagstat.stderr
    """
}

workflow {
    // Serial execution chain
    samtools_idxstats()
    samtools_flagstat()
}
