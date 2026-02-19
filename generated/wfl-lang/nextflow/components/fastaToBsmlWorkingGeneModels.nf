#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: fastaToBsmlWorkingGeneModels
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bsml_dtd = ''
    database = ''
    debug = ''
    fasta_directory = ''
    genus = ''
    group_number = ''
    input_fasta_file = ''
    iterator_name = ''
    output_directory = ''
    project_id_repository = ''
    sequence_id = ''
    species = ''
    tmp_dir = ''
}

process Create_the_FASTA_output_directory {
    script:
    """
    mkdir -p -m 777 ${params.fasta_directory}/${params.iterator_name}/g${params.group_number}/
    """
}

process fastaToBsmlWorkingGeneModels {
    script:
    """
    ${params.bin_dir}/fastaToBsmlWorkingGeneModels --database ${params.database} --sequenceId ${params.sequence_id} --infile ${params.input_fasta_file} --outfile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.sequence_id}.bsml --logfile ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.sequence_id}.fastaToBsmlWorkingGeneModels.pl.log --debug_level ${params.debug} --genus ${params.genus} --species '${params.species}' --id-repository ${params.project_id_repository} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/fastaToBsmlWorkingGeneModels.${params.sequence_id}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/fastaToBsmlWorkingGeneModels.{{SEQUENCE_ID}}.stderr
    """
}

process DTD_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl -d ${params.bsml_dtd} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.sequence_id}.bsml
    """
}

process profileBSMLFile {
    script:
    """
    ${params.bin_dir}/profileBSMLFile --infile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.sequence_id}.bsml --database ${params.database} --asmbl_id ${params.sequence_id} --logfile ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.sequence_id}.profileBSMLFile.pl.log \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/profileBSMLFile.${params.sequence_id}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/profileBSMLFile.{{SEQUENCE_ID}}.stderr
    """
}

workflow {
    // Serial execution chain
    Create_the_FASTA_output_directory()
    fastaToBsmlWorkingGeneModels()
    DTD_validation()
    profileBSMLFile()
}
