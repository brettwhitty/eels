#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: validate_sgc_records
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database_list = ''
    email_list = ''
    workflow_repository = ''
}

process create_iterator_list {
    script:
    """
    ${params.bin_dir}/create_iterator_list --input_list ${params.database_list} --key DATABASE --output_iter_list ${params.workflow_repository}/database.list \
        1>${params.workflow_repository}/create_iterator_list.pl.stdout \
        2>{{WORKFLOW_REPOSITORY}}/create_iterator_list.pl.stderr
    """
}

process generate_and_email_report {
    script:
    """
    ${params.bin_dir}/generateCheckSmallGenomeDBReport.pl --database-list ${params.database_list} --email-list ${params.email_list} --output_repository ${params.workflow_repository} --logfile ${params.workflow_repository}/generateCheckSmallGenomeDBReport.pl.log --report-file ${params.workflow_repository}/checkSmallGenomeDBReport.report.txt \
        1>${params.workflow_repository}/generateCheckSmallGenomeDBReport.pl.stdout \
        2>{{WORKFLOW_REPOSITORY}}/generateCheckSmallGenomeDBReport.pl.stderr
    """
}

workflow {
    // Serial execution chain
    create_iterator_list()
    generate_and_email_report()
}
