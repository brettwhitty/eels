#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: expression_plots
// Generated from Ergatis component JSON by EELS

params {
    analysis = ''
    bin_dir = ''
    fdr = ''
    gene_col = ''
    group_number = ''
    input_file = ''
    iterator_name = ''
    lfc = ''
    other_args = ''
    output_directory = ''
    rpkm_col = ''
    r_bin_dir = ''
    r_params = ''
    r_script = ''
}

process expression_plots {
    script:
    """
    ${params.bin_dir}/expression_plots ${params.other_args} --infile ${params.input_file} --analysis ${params.analysis} --lfc ${params.lfc} --fdr ${params.fdr} --gene_col ${params.gene_col} --rpkm_col ${params.rpkm_col} --outdir ${params.output_directory}/${params.iterator_name}/g${params.group_number} --r_bin_dir '${params.r_bin_dir}' --r_params '${params.r_params}' --r_script ${params.r_script} \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/expression_plots.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/expression_plots.stderr
    """
}

workflow {
    // Serial execution chain
    expression_plots()
}
