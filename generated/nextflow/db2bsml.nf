#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: db2bsml
// Generated from Ergatis component JSON by EELS

params {
    asmbl_id = ''
    bin_dir = ''
    bsml_dtd = ''
    database = ''
    debug = ''
    fasta_directory = ''
    group_number = ''
    host = ''
    input_id_mapping_directories = ''
    input_id_mapping_files = ''
    iterator_name = ''
    output_directory = ''
    password = ''
    project_id_repository = ''
    rdbms = ''
    tmp_dir = ''
    username = ''
}

process Create_the_FASTA_output_directory {
    script:
    """
    mkdir -p -m 777 ${params.fasta_directory}/${params.iterator_name}/g${params.group_number}/
    """
}

process db2bsml {
    script:
    """
    ${params.bin_dir}/db2bsml --database ${params.database} --password ${params.password} --username ${params.username} --server ${params.host} --vendor ${params.rdbms} --outfile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}_assembly.bsml --logfile ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.database}.${params.asmbl_id}.db2bsml.pl.log --debug_level ${params.debug} --fastadir ${params.fasta_directory}/${params.iterator_name}/g${params.group_number}/ --asmbl_id ${params.asmbl_id} --id_repository ${params.project_id_repository} --in-id-map-dir '${params.input_id_mapping_directories}' --in-id-map-file '${params.input_id_mapping_files}' --out_id_map_file ${params.tmp_dir}/id_mapping/${params.database}_${params.asmbl_id}.idmap --sourcename ${params.output_directory} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/db2bsml.${params.database}.${params.asmbl_id}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/db2bsml.{{DATABASE}}.{{ASMBL_ID}}.stderr
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
    ${params.bin_dir}/profileBSMLFile --infile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}_assembly.bsml --database ${params.database} --asmbl_id ${params.asmbl_id} --logfile ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.database}.${params.asmbl_id}.profileBSMLFile.pl.log \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/profileBSMLFile.${params.database}.${params.asmbl_id}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/profileBSMLFile.{{DATABASE}}.{{ASMBL_ID}}.stderr
    """
}

workflow {
    // Serial execution chain
    Create_the_FASTA_output_directory()
    db2bsml()
    DTD_validation()
    profileBSMLFile()
}
