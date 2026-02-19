#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: validate_euk_records
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    output_directory = ''
    tmp_dir = ''
    validate_euk_records_control_file = ''
}

process create_output_and_temporary_directories {
    script:
    """
    mkdir -p -m 777 ${params.output_directory} ${params.tmp_dir}
    """
}

process Create_validate_euk_records_master_iterator_list_file {
    script:
    """
    ${params.bin_dir}/create_legacy2bsml_iterator_list --control_file ${params.validate_euk_records_control_file} --output ${params.tmp_dir}/validate_euk_records.list \
        1>${params.tmp_dir}/create_validate_euk_records_iterator_list.stdout \
        2>{{TMP_DIR}}/create_validate_euk_records_iterator_list.stderr
    """
}

workflow {
    // Serial execution chain
    create_output_and_temporary_directories()
    Create_validate_euk_records_master_iterator_list_file()
}
