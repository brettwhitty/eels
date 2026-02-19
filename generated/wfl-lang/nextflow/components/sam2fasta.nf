#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: sam2fasta
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    combine_mates = ''
    fastq = ''
    hlgt = ''
    host = ''
    input_file = ''
    output_bases = ''
    output_file = ''
    output_list = ''
    samtools_exec = ''
    tmp_dir = ''
}

process Convert_sam_to_fasta {
    script:
    """
    ${params.bin_dir}/sam2fasta --file_list ${params.input_file} --fastq ${params.fastq} --hlgt ${params.hlgt} --output_file ${params.output_file} --tmp_dir ${params.tmp_dir} --base_list ${params.output_bases} --host ${params.host} --out_list ${params.output_list} --combine_mates ${params.combine_mates} --samtools_bin ${params.samtools_exec} \
        1>${params.output_directory}/lgt_sam2fasta.stdout \
        2>{{OUTPUT_DIRECTORY}}/lgt_sam2fasta.stderr
    """
}

workflow {
    // Serial execution chain
    Convert_sam_to_fasta()
}
