#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: clean_fasta
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    config_options = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    nucleotide = ''
    output_directory = ''
    tmp_dir = ''
}

process create_clean_fasta_directory {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/${params.iterator_name}/g${params.group_number}/clean_fasta
    """
}

process remove_CR_line_breaks {
    script:
    """
    /usr/bin/perl -p -w -e "s/\r//g" ${params.i_file_path} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}_tmp.fasta
    """
}

process clean_fasta {
    script:
    """
    ${params.bin_dir}/clean_fasta ${params.config_options} ${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}_tmp.fasta -o ${params.output_directory}/${params.iterator_name}/g${params.group_number}/clean_fasta/${params.i_file_base}.fasta \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.clean_fasta.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.clean_fasta.stderr
    """
}

process create_cf_directory {
    script:
    """
    mkdir -p -m 777 ${params.output_directory}/${params.iterator_name}/g${params.group_number}/final_clean
    """
}

process replace_gaps_in_nucleotides {
    script:
    """
    ${params.bin_dir}/replace_nuc_gaps --input_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/clean_fasta/${params.i_file_base}.fasta --output_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/final_clean/${params.i_file_base}.fasta --nucleotide ${params.nucleotide} \
        1>${params.tmp_dir}/${params.iterator_name}/g${params.group_number}/${params.component_name}_${params.i_file_base}.final_clean.stdout \
        2>{{TMP_DIR}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{COMPONENT_NAME}}_{{I_FILE_BASE}}.final_clean.stderr
    """
}

workflow {
    // Serial execution chain
    create_clean_fasta_directory()
    remove_CR_line_breaks()
    clean_fasta()
    create_cf_directory()
    replace_gaps_in_nucleotides()
}
