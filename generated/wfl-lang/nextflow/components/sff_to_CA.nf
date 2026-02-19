#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: sff_to_CA
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    clear = ''
    input_file = ''
    input_file_list = ''
    insert_size = ''
    library = ''
    linker = ''
    output_directory = ''
    sfftoca_exec = ''
    trim = ''
}

process sffToCA {
    script:
    """
    ${params.bin_dir}/sff_to_CA --sff_to_CA_exe ${params.sfftoca_exec} --sff_file ${params.input_file} --sff_file_list ${params.input_file_list} --library ${params.library} --linker ${params.linker} --trim ${params.trim} --clear ${params.clear} --insert_size "${params.insert_size}" --output ${params.output_directory}/${params.library}.frg \
        1>${params.tmp_dir}/sff_to_CA.stdout \
        2>{{TMP_DIR}}/sff_to_CA.stderr
    """
}

workflow {
    // Serial execution chain
    sffToCA()
}
