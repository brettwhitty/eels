#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: phylip_dnadist
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    dnadist_sort = ''
    dnadist_worker = ''
    group_number = ''
    iterator_name = ''
    i_end_cell = ''
    i_start_cell = ''
    output_directory = ''
}

process dnadist_worker_wrapper {
    script:
    """
    ${params.bin_dir}/dnadist_worker_wrapper --dnadist_worker_path ${params.dnadist_worker} --control_file ${params.output_directory}/dnadist_control_file.txt --start_cell ${params.i_start_cell} --end_cell ${params.i_end_cell} --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_start_cell}-${params.i_end_cell}.distances.unsorted \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.i_start_cell}-${params.i_end_cell}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_START_CELL}}-{{I_END_CELL}}.stderr
    """
}

process sort_output {
    script:
    """
    ${params.dnadist_sort} -n ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_start_cell}-${params.i_end_cell}.distances.unsorted > ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_start_cell}-${params.i_end_cell}.distances 
    """
}

process remove_unsorted_output {
    script:
    """
    rm ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_start_cell}-${params.i_end_cell}.distances.unsorted
    """
}

workflow {
    // Serial execution chain
    dnadist_worker_wrapper()
    sort_output()
    remove_unsorted_output()
}
