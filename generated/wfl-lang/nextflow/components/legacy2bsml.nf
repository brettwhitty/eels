#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: legacy2bsml
// Generated from Ergatis component JSON by EELS

params {
    alt_database = ''
    alt_species = ''
    asmbl_id = ''
    bin_dir = ''
    bsml_dtd = ''
    database = ''
    debug = ''
    exclude_genefinders = ''
    fasta_directory = ''
    group_number = ''
    host = ''
    idgen_identifier_version = ''
    include_genefinders = ''
    input_id_mapping_directories = ''
    input_id_mapping_files = ''
    iterator_name = ''
    mode = ''
    model_list_file = ''
    no_die_null_sequences = ''
    output_directory = ''
    password = ''
    project_id_repository = ''
    rdbms = ''
    schema_type = ''
    sequence_type = ''
    tmp_dir = ''
    tu_list_file = ''
    username = ''
}

process Create_the_FASTA_output_directory {
    script:
    """
    mkdir -p -m 777 ${params.fasta_directory}/${params.iterator_name}/g${params.group_number}/
    """
}

process legacy2bsml {
    script:
    """
    ${params.bin_dir}/legacy2bsml --database ${params.database} --password ${params.password} --username ${params.username} --host ${params.host} --rdbms ${params.rdbms} --mode ${params.mode} --bsml_doc_name ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}_assembly.${params.schema_type}.bsml --log4perl ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.database}.${params.asmbl_id}.${params.schema_type}.legacy2bsml.pl.log --debug_level ${params.debug} --fastadir ${params.fasta_directory}/${params.iterator_name}/g${params.group_number}/ --asmbl_id ${params.asmbl_id} --schema_type ${params.schema_type} --sequence_type ${params.sequence_type} --exclude_genefinders ${params.exclude_genefinders} --include_genefinders ${params.include_genefinders} --alt_database ${params.alt_database} --alt_species ${params.alt_species} --id_repository ${params.project_id_repository} --input_id_mapping_directories '${params.input_id_mapping_directories}' --input_id_mapping_files '${params.input_id_mapping_files}' --output_id_mapping_file ${params.tmp_dir}/id_mapping/${params.database}_${params.asmbl_id}_${params.schema_type}.idmap --idgen_identifier_version ${params.idgen_identifier_version} --tu_list_file ${params.tu_list_file} --model_list_file ${params.model_list_file} --no_die_null_sequences ${params.no_die_null_sequences} --sourcename ${params.output_directory} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/legacy2bsml.${params.database}.${params.asmbl_id}.${params.schema_type}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/legacy2bsml.{{DATABASE}}.{{ASMBL_ID}}.{{SCHEMA_TYPE}}.stderr
    """
}

process DTD_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl -d ${params.bsml_dtd} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}_assembly.${params.schema_type}.bsml
    """
}

process profileBSMLFile {
    script:
    """
    ${params.bin_dir}/profileBSMLFile --infile ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.database}_${params.asmbl_id}_assembly.${params.schema_type}.bsml --database ${params.database} --asmbl_id ${params.asmbl_id} --logfile ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.database}.${params.asmbl_id}.${params.schema_type}.profileBSMLFile.pl.log \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/profileBSMLFile.${params.database}.${params.asmbl_id}.${params.schema_type}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/profileBSMLFile.{{DATABASE}}.{{ASMBL_ID}}.{{SCHEMA_TYPE}}.stderr
    """
}

workflow {
    // Serial execution chain
    Create_the_FASTA_output_directory()
    legacy2bsml()
    DTD_validation()
    profileBSMLFile()
}
