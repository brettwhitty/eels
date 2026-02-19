#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: profile_gff3
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
}

process Profile_GFF3_file {
    script:
    """
    ${params.bin_dir}/gff3Profiler ${params.i_file_path} ${params.output_directory}/gff3Profiler.pl.${params.i_file_base}.prof \
        1>${params.tmp_dir}/gff3Profiler.pl.${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/gff3Profiler.pl.{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    Profile_GFF3_file()
}
