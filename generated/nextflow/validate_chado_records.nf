#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: validate_chado_records
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    database = ''
    debug = ''
    password = ''
    rdbms = ''
    server = ''
    username = ''
    workflow_repository = ''
}

process Check_for_duplicate_analysisprop_records {
    script:
    """
    ${params.bin_dir}/checkForDuplicatePropertyTuples --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.username} --password ${params.password} --debug_level ${params.debug} --logfile ${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.analysisprop.log --table analysisprop \
        1>${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.analysisprop.stdout \
        2>{{WORKFLOW_REPOSITORY}}/checkForDuplicatePropertyTuples.pl.analysisprop.stderr
    """
}

process Check_for_duplicate_dbxrefprop_records {
    script:
    """
    ${params.bin_dir}/checkForDuplicatePropertyTuples --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.username} --password ${params.password} --debug_level ${params.debug} --logfile ${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.dbxrefprop.log --table dbxrefprop \
        1>${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.dbxrefprop.stdout \
        2>{{WORKFLOW_REPOSITORY}}/checkForDuplicatePropertyTuples.pl.dbxrefprop.stderr
    """
}

process Check_for_duplicate_featureprop_records {
    script:
    """
    ${params.bin_dir}/checkForDuplicatePropertyTuples --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.username} --password ${params.password} --debug_level ${params.debug} --logfile ${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.featureprop.log --table featureprop \
        1>${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.featureprop.stdout \
        2>{{WORKFLOW_REPOSITORY}}/checkForDuplicatePropertyTuples.pl.featureprop.stderr
    """
}

process Check_for_duplicate_feature_cvtermprop_records {
    script:
    """
    ${params.bin_dir}/checkForDuplicatePropertyTuples --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.username} --password ${params.password} --debug_level ${params.debug} --logfile ${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.feature_cvtermprop.log --table feature_cvtermprop \
        1>${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.feature_cvtermprop.stdout \
        2>{{WORKFLOW_REPOSITORY}}/checkForDuplicatePropertyTuples.pl.feature_cvtermprop.stderr
    """
}

process Check_for_duplicate_feature_relationshipprop_records {
    script:
    """
    ${params.bin_dir}/checkForDuplicatePropertyTuples --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.username} --password ${params.password} --debug_level ${params.debug} --logfile ${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.feature_relationshipprop.log --table feature_relationshipprop \
        1>${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.feature_relationshipprop.stdout \
        2>{{WORKFLOW_REPOSITORY}}/checkForDuplicatePropertyTuples.pl.feature_relationshipsprop.stderr
    """
}

process Check_for_duplicate_organismprop_records {
    script:
    """
    ${params.bin_dir}/checkForDuplicatePropertyTuples --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.username} --password ${params.password} --debug_level ${params.debug} --logfile ${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.organismprop.log --table organismprop \
        1>${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.organismprop.stdout \
        2>{{WORKFLOW_REPOSITORY}}/checkForDuplicatePropertyTuples.pl.organismprop.stderr
    """
}

process Check_for_duplicate_phylonodeprop_records {
    script:
    """
    ${params.bin_dir}/checkForDuplicatePropertyTuples --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.username} --password ${params.password} --debug_level ${params.debug} --logfile ${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.phylonodeprop.log --table phylonodeprop \
        1>${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.phylonodeprop.stdout \
        2>{{WORKFLOW_REPOSITORY}}/checkForDuplicatePropertyTuples.pl.phylonodeprop.stderr
    """
}

process Check_for_duplicate_pubprop_records {
    script:
    """
    ${params.bin_dir}/checkForDuplicatePropertyTuples --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.username} --password ${params.password} --debug_level ${params.debug} --logfile ${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.pubprop.log --table pubprop \
        1>${params.workflow_repository}/checkForDuplicatePropertyTuples.pl.pubprop.stdout \
        2>{{WORKFLOW_REPOSITORY}}/checkForDuplicatePropertyTuples.pl.pubprop.stderr
    """
}

process Check_for_fmin_fmax_and_valid_strand_featureloc_records {
    script:
    """
    ${params.bin_dir}/checkFeaturelocRecords --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.username} --password ${params.password} --debug_level ${params.debug} --logfile ${params.workflow_repository}/checkFeaturelocRecords.pl.log \
        1>${params.workflow_repository}/checkFeaturelocRecords.pl.stdout \
        2>{{WORKFLOW_REPOSITORY}}/checkFeaturelocRecords.pl.stderr
    """
}

process Check_for_feature_residues_seqlen_mismatches {
    script:
    """
    ${params.bin_dir}/checkForFeatureResiduesSeqlenMismatches --database ${params.database} --database_type ${params.rdbms} --server ${params.server} --username ${params.username} --password ${params.password} --debug_level ${params.debug} --logfile ${params.workflow_repository}/checkForFeatureResiduesSeqlenMismatches.pl.log \
        1>${params.workflow_repository}/checkForFeatureResiduesSeqlenMismatches.pl.stdout \
        2>{{WORKFLOW_REPOSITORY}}/checkForFeatureResiduesSeqlenMismatches.pl.stderr
    """
}

workflow {
    // Serial execution chain
    Check_for_duplicate_analysisprop_records()
    Check_for_duplicate_dbxrefprop_records()
    Check_for_duplicate_featureprop_records()
    Check_for_duplicate_feature_cvtermprop_records()
    Check_for_duplicate_feature_relationshipprop_records()
    Check_for_duplicate_organismprop_records()
    Check_for_duplicate_phylonodeprop_records()
    Check_for_duplicate_pubprop_records()
    Check_for_fmin_fmax_and_valid_strand_featureloc_records()
    Check_for_feature_residues_seqlen_mismatches()
}
