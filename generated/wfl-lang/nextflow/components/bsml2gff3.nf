#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: bsml2gff3
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    gbrowse = ''
    gbrowse_dbxref_map = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    project = ''
    translation_table = ''
}

process bsml2gff3 {
    script:
    """
    ${params.bin_dir}/bsml2gff3 --bsml_file_name ${params.i_file_path} --gff_file_name ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.gff3 --source ${params.project} --translation_table ${params.translation_table} --gbrowse ${params.gbrowse} --gbrowse_name_mapping ${params.gbrowse_dbxref_map} --logfile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.bsml2gff3.log \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    bsml2gff3()
}
