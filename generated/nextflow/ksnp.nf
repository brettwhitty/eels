#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: ksnp
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    component_name = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    ksnp_dir = ''
    ksnp_exec = ''
    kmer = ''
    output_directory = ''
    output_token = ''
    reference_genbank = ''
}

process merge_contigs {
    script:
    """
    ${params.bin_dir}/ksnp_merge_reference  >${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.merged.fsa  --input ${params.i_file_path}
    """
}

process parse_reference_fasta_header {
    script:
    """
    ${params.ksnp_dir}/genome_names.pl ${params.output_directory}/${params.component_name}.${params.output_token}.fna >${params.output_directory}/${params.iterator_name}/g${params.group_number}/ksnp.reference
    """
}

process merge_input_and_reference {
    script:
    """
    cat ${params.output_directory}/${params.component_name}.${params.output_token}.fna ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.merged.fsa >${params.output_directory}/${params.iterator_name}/g${params.group_number}/inputandref.fsa
    """
}

process ksnp {
    script:
    """
    ${params.ksnp_exec}  -f ${params.output_directory}/${params.iterator_name}/g${params.group_number}/inputandref.fsa -d ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ -k ${params.kmer} -p ${params.output_directory}/${params.iterator_name}/g${params.group_number}/ksnp.reference \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

process create_raw_output {
    script:
    """
    mv ${params.output_directory}/${params.iterator_name}/g${params.group_number}/SNPs_all_labelLoci ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.stdout
    """
}

process convert_ksnp_to_nucmer_output {
    script:
    """
    ${params.bin_dir}/ksnp_to_addgeneinfo  >${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.ksnp2nucmer.snps --input ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.raw
    """
}

process convert_nucmer_output_to_snp_add_gene_info {
    script:
    """
    ${params.bin_dir}/ksnp-add-gene-info --reference_genbank ${params.reference_genbank} --show_snps_file ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.ksnp2nucmer.snps --query_fasta ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.merged.fsa --output ${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.ksnp-show-genes.tab \
        1>${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.ksnp-show-genes.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.ksnp-show-genes.stderr
    """
}

process remove_temp_dir {
    script:
    """
    rm -rf ${params.output_directory}/${params.iterator_name}/g${params.group_number}/TemporaryFilesToDelete
    """
}

process remove_fsplit_dir {
    script:
    """
    rm -rf ${params.output_directory}/${params.iterator_name}/g${params.group_number}/Dir.fsplit*
    """
}

workflow {
    // Serial execution chain
    merge_contigs()
    parse_reference_fasta_header()
    merge_input_and_reference()
    ksnp()
    create_raw_output()
    convert_ksnp_to_nucmer_output()
    convert_nucmer_output_to_snp_add_gene_info()
    remove_temp_dir()
    remove_fsplit_dir()
}
