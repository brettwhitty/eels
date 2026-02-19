#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: glk2bsml
// Generated from Ergatis component JSON by EELS

params {
    asmbl_id = ''
    bin_dir = ''
    bsml_dtd = ''
    database = ''
    genus = ''
    group_number = ''
    id_gen_version = ''
    iterator_name = ''
    output_directory = ''
    password = ''
    project_id_repository = ''
    server = ''
    tmp_dir = ''
    username = ''
}

process glk2bsml {
    script:
    """
    ${params.bin_dir}/glk2bsml --database ${params.database} --server ${params.server} --password ${params.password} --username ${params.username} --id_repository ${params.project_id_repository} --id_gen_version ${params.id_gen_version} --bsmlfile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}_assembly.bsml --bac_id ${params.asmbl_id} --genus ${params.genus} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/glk2bsml.${params.database}_${params.asmbl_id}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/glk2bsml.{{DATABASE}}_{{ASMBL_ID}}.stderr
    """
}

process DTD_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl -d ${params.bsml_dtd} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}_assembly.bsml
    """
}

process profileBSMLFile {
    script:
    """
    ${params.bin_dir}/profileBSMLFile --infile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}_assembly.bsml --database ${params.database} --asmbl_id ${params.asmbl_id} --logfile ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}.profileBSMLFile.pl.log \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/profileBSMLFile.${params.database}_${params.asmbl_id}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/profileBSMLFile.{{DATABASE}}_{{ASMBL_ID}}.stderr
    """
}

workflow {
    // Serial execution chain
    glk2bsml()
    DTD_validation()
    profileBSMLFile()
}
