#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: condor_cogs_search
// Generated from Ergatis component JSON by EELS

params {
    asmbl_id = ''
    bin_dir = ''
    database = ''
    password = ''
    username = ''
    workflow_repository = ''
}

process Create_database_output_directory {
    script:
    """
    mkdir -p -m 777 ${params.workflow_repository}/${params.database}_${params.asmbl_id}
    """
}

process condor_cog_search_dbi {
    script:
    """
    ${params.bin_dir}/condor_cog_search -u ${params.username} -p ${params.password} -D ${params.database}  -a ${params.asmbl_id} \
        1>${params.workflow_repository}/${params.database}_${params.asmbl_id}/condor_cog_search.dbi.stdout \
        2>{{WORKFLOW_REPOSITORY}}/{{DATABASE}}_{{ASMBL_ID}}/condor_cog_search.dbi.stderr
    """
}

workflow {
    // Serial execution chain
    Create_database_output_directory()
    condor_cog_search_dbi()
}
