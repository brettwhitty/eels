#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: chado_report_pages
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database = ''
    model_list_file = ''
    password = ''
    reportfile = ''
    server = ''
    tmp_dir = ''
    username = ''
}

process Generate_chado_report_pages_for_database____PROJECT____on_server____SERVER___ {
    script:
    """
    ${params.bin_dir}/generateChadoReportPages --username ${params.username} --password ${params.password} --database ${params.database} --server ${params.server} --model_list_file ${params.model_list_file} --reportfile ${params.reportfile} --logfile ${params.tmp_dir}/generateChadoReportPages.pl.log \
        1>${params.tmp_dir}/generateChadoReportPages.pl.stdout \
        2>{{TMP_DIR}}/generateChadoReportPages.pl.stderr
    """
}

workflow {
    // Serial execution chain
    Generate_chado_report_pages_for_database____PROJECT____on_server____SERVER___()
}
