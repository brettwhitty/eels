#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mothur_chimera_slayer
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bootiters = ''
    divergence = ''
    group_number = ''
    iterator_name = ''
    i_file_name = ''
    i_file_path = ''
    minbootsupport = ''
    mincov = ''
    minsim = ''
    mothur_exec = ''
    output_directory = ''
    split = ''
    template_file = ''
}

process chimera_slayer {
    script:
    """
    ${params.bin_dir}/mothur --mothur_exe ${params.mothur_exec} --input_file ${params.i_file_path} --output_dir ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ --args "#chimera.slayer(fasta=${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_name}, template=${params.template_file}, minsim=${params.minsim}, mincov=${params.mincov}, iters=${params.bootiters}, minbs=${params.minbootsupport}, divergence=${params.divergence}, split=${params.split})" \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.stderr
    """
}

workflow {
    // Serial execution chain
    chimera_slayer()
}
