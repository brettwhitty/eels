#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: formatdb_snp
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database_name = ''
    group_number = ''
    iterator_name = ''
    i_file_path = ''
    other_formatdb_args = ''
    output_directory = ''
    protein = ''
}

process formatdb {
    script:
    """
    ${params.bin_dir}/formatdb_snp --input_files '${params.i_file_path}' --formatdb_path '/usr/local/bin/formatdb' --protein ${params.protein} --database_name ${params.database_name} --other_args '${params.other_formatdb_args}' --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    formatdb()
}
