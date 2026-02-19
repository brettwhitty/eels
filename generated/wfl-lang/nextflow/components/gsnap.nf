#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: gsnap
// Generated from Ergatis component JSON by EELS

params {
    expected_paired_length = ''
    gmap_setup_exec = ''
    gsnap_exec = ''
    indel_end_length = ''
    indel_penalty = ''
    max_mismatches = ''
    max_paired_length = ''
    max_paths = ''
    other_gmap_setup_options = ''
    output_directory = ''
    output_format = ''
    reads = ''
    reference = ''
    threads = ''
}

process create_gmapdb_directory {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/gmapdb
    """
}

process gmap_setup {
    script:
    """
    ${params.gmap_setup_exec} -d reference -o ${params.output_directory}/Makefile.reference -D ${params.output_directory}/gmapdb ${params.reference} ${params.other_gmap_setup_options} \
        1>${params.output_directory}/gmap_setup.stdout \
        2>{{OUTPUT_DIRECTORY}}/gmap_setup.stderr
    """
}

process gmapdb_Makefiles {
    script:
    """
    make -f ${params.output_directory}/Makefile.reference coords
    """
}

process gmapdb_Makefiles {
    script:
    """
    make -f ${params.output_directory}/Makefile.reference gmapdb
    """
}

process gmapdb_Makefiles {
    script:
    """
    make -f ${params.output_directory}/Makefile.reference install
    """
}

process gsnap {
    script:
    """
    ${params.gsnap_exec} -d reference -D ${params.output_directory}/gmapdb -m ${params.max_mismatches} -i ${params.indel_penalty} -I ${params.indel_end_length} -P ${params.max_paired_length} -p ${params.expected_paired_length} -T ${params.threads} -n ${params.max_paths} -A ${params.output_format} ${params.reads} > ${params.output_directory}/hits.sam  \
        1>${params.output_directory}/gsnap_log.stdout \
        2>{{OUTPUT_DIRECTORY}}/gsnap_log.stderr
    """
}

workflow {
    // Serial execution chain
    create_gmapdb_directory()
    gmap_setup()
    gmapdb_Makefiles()
    gmapdb_Makefiles()
    gmapdb_Makefiles()
    gsnap()
}
