#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: gff3_to_gbrowse
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    db_name = ''
    gbrowse_conf_directory = ''
    gbrowse_conf_template = ''
    gbrowse_master_conf = ''
    hostname = ''
    i_file_path = ''
    organism = ''
    password = ''
    python_exec = ''
    sam_file = ''
    username = ''
}

process gff32GBrowse {
    script:
    """
    ${params.python_exec} ${params.bin_dir}/gff3_to_gbrowse.py --input_gff3_file ${params.i_file_path} --input_sam_file ${params.sam_file} --gbrowse_conf_template ${params.gbrowse_conf_template} --organism "${params.organism}" --gbrowse_master_conf ${params.gbrowse_master_conf} --gbrowse_conf_dir ${params.gbrowse_conf_directory} --database "${params.db_name}" --hostname ${params.hostname} --username ${params.username} --password ${params.password} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    gff32GBrowse()
}
