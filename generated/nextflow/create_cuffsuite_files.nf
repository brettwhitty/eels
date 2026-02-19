#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: create_cuffsuite_files
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    cuff_prog = ''
    grp_comp = ''
    gtffile = ''
    gtf_listfile = ''
    other_args = ''
    output_directory = ''
    sample_info = ''
    sam_listfile = ''
}

process create_cuffsuite_files {
    script:
    """
    ${params.bin_dir}/create_cuffsuite_files ${params.other_args} --infile ${params.sample_info} --cuff_prog ${params.cuff_prog} --comp_grps ${params.grp_comp} --gtf ${params.gtffile} --gtflist ${params.gtf_listfile} --samlist ${params.sam_listfile} --outdir ${params.output_directory} \
        1>${params.output_directory}/create_cuffsuite_files.stdout \
        2>{{OUTPUT_DIRECTORY}}/create_cuffsuite_files.stderr
    """
}

workflow {
    // Serial execution chain
    create_cuffsuite_files()
}
