#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: validate_asn
// Generated from Ergatis component JSON by EELS

params {
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    output_directory = ''
    tmp_dir = ''
}

process Create_the_asnval_and_asndisc_temp_output_directories {
    script:
    """
    mkdir -p -m 777 ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/
    """
}

process Create_the_asnval_and_asndisc_output_directories {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}/ \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.mkdir.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.mkdir.stderr
    """
}

process Run_asnval {
    script:
    """
    /usr/local/bin/asnval -i ${params.i_file_path} -o ${params.output_directory}/g${params.group_number}/${params.i_file_base}.asnval.rpt \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.asnval.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.asnval.stderr
    """
}

process Run_asndisc {
    script:
    """
    /usr/local/bin/asndisc -i ${params.i_file_path} -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.discrpt \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.asndisc.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.asndisc.stderr
    """
}

workflow {
    // Serial execution chain
    Create_the_asnval_and_asndisc_temp_output_directories()
    Create_the_asnval_and_asndisc_output_directories()
    Run_asnval()
    Run_asndisc()
}
