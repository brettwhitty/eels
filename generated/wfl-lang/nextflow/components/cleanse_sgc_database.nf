#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: cleanse_sgc_database
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database = ''
    password = ''
    username = ''
    workflow_repository = ''
}

process Create_database_output_directory {
    script:
    """
    mkdir -p -m 777 ${params.workflow_repository}/${params.database}
    """
}

process rewrite_seqs_dbi {
    script:
    """
    ${params.bin_dir}/rewrite_seqs -u ${params.username} -p ${params.password} -D ${params.database} \
        1>${params.workflow_repository}/${params.database}/rewrite_seqs.dbi.stdout \
        2>{{WORKFLOW_REPOSITORY}}/{{DATABASE}}/rewrite_seqs.dbi.stderr
    """
}

process sgc_GC_content_load_spl {
    script:
    """
    ${params.bin_dir}/sgc_GC_content_load -u ${params.username} -p ${params.password} -D ${params.database} \
        1>${params.workflow_repository}/${params.database}/RNA_populate.dbi.stdout \
        2>{{WORKFLOW_REPOSITORY}}/{{DATABASE}}/RNA_populate.dbi.stderr
    """
}

process molwt_update_dbi {
    script:
    """
    ${params.bin_dir}/molwt_update -u ${params.username} -p ${params.password} -D ${params.database} \
        1>${params.workflow_repository}/${params.database}/molwt_update.dbi.stdout \
        2>{{WORKFLOW_REPOSITORY}}/{{DATABASE}}/molwt_update.dbi.stderr
    """
}

process signalP_update_dbi {
    script:
    """
    ${params.bin_dir}/signalP_update -u ${params.username} -p ${params.password} -D ${params.database} \
        1>${params.workflow_repository}/${params.database}/signalP_update.dbi.stdout \
        2>{{WORKFLOW_REPOSITORY}}/{{DATABASE}}/signalP_update.dbi.stderr
    """
}

process lipoprotein_update_dbi {
    script:
    """
    ${params.bin_dir}/lipoprotein_update -u ${params.username} -p ${params.password} -D ${params.database} \
        1>${params.workflow_repository}/${params.database}/lipoprotein_update.dbi.stdout \
        2>{{WORKFLOW_REPOSITORY}}/{{DATABASE}}/lipoprotein_update.dbi.stderr
    """
}

process tm_update_dbi {
    script:
    """
    ${params.bin_dir}/tm_update -u ${params.username} -p ${params.password} -D ${params.database} \
        1>${params.workflow_repository}/${params.database}/tm_update.dbi.stdout \
        2>{{WORKFLOW_REPOSITORY}}/{{DATABASE}}/tm_update.dbi.stderr
    """
}

process omp_update_dbi {
    script:
    """
    ${params.bin_dir}/omp_update -u ${params.username} -p ${params.password} -D ${params.database} \
        1>${params.workflow_repository}/${params.database}/omp_update.dbi.stdout \
        2>{{WORKFLOW_REPOSITORY}}/{{DATABASE}}/omp_update.dbi.stderr
    """
}

workflow {
    // Serial execution chain
    Create_database_output_directory()
    rewrite_seqs_dbi()
    sgc_GC_content_load_spl()
    molwt_update_dbi()
    signalP_update_dbi()
    lipoprotein_update_dbi()
    tm_update_dbi()
    omp_update_dbi()
}
