#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: chado2bsml
// Generated from Ergatis component JSON by EELS

params {
    asmbl = ''
    bin_dir = ''
    bsml_dtd = ''
    database = ''
    database_type = ''
    debug = ''
    fasta_directory = ''
    group_number = ''
    ignore_evcodes = ''
    ignore_go = ''
    ignore_non_go = ''
    iterator_name = ''
    output_directory = ''
    password = ''
    polypeptides_only = ''
    server = ''
    tmp_dir = ''
    username = ''
}

process Create_the_FASTA_output_directory {
    script:
    """
    mkdir -p -m 777 ${params.fasta_directory}/${params.iterator_name}/g${params.group_number}/
    """
}

process chado2bsml {
    script:
    """
    ${params.bin_dir}/chado2bsml --database ${params.database} --database_type ${params.database_type} --server ${params.server} --password ${params.password} --username ${params.username} --asmbl ${params.asmbl} --ignore_go ${params.ignore_go} --ignore_evcodes ${params.ignore_evcodes} --ignore_non_go ${params.ignore_non_go} --polypeptides_only ${params.polypeptides_only} --bsml_file_name ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.asmbl}.bsml --logfile ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/chado2bsml.pl.${params.asmbl}.log --debug ${params.debug} --fastadir ${params.fasta_directory}/${params.iterator_name}/g${params.group_number}/ \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/chado2bsml.${params.asmbl}.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/chado2bsml.{{ASMBL}}.stderr
    """
}

process DTD_validation {
    script:
    """
    ${params.bin_dir}/dtdValid.pl -d ${params.bsml_dtd} ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.asmbl}.bsml
    """
}

workflow {
    // Serial execution chain
    Create_the_FASTA_output_directory()
    chado2bsml()
    DTD_validation()
}
