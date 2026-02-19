#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mugsyprep
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    fasta_file_list = ''
    output_directory = ''
    use_polypeptides = ''
}

process create_fasta_output_directory {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/fasta
    """
}

process concatenate_files {
    script:
    """
    for i in `cat ${params.output_directory}/mugsymap.list`; do cat $i; done >> ${params.output_directory}/mugsymap_complete.txt
    """
}

process prep_fasta_for_mugsy {
    script:
    """
    ${params.bin_dir}/prepfasta4mugsy --input_list ${params.fasta_file_list} --mugsy_map ${params.output_directory}/mugsymap_complete.txt --output_dir ${params.output_directory}/fasta --use_polypeptides ${params.use_polypeptides} \
        1>${params.workflow_repository}/prepfasta4mugsy.stdout \
        2>{{WORKFLOW_REPOSITORY}}/prepfasta4mugsy.stderr
    """
}

workflow {
    // Serial execution chain
    create_fasta_output_directory()
    concatenate_files()
    prep_fasta_for_mugsy()
}
