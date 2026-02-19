#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mugsy_callsnps_distributed
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    fasta = ''
    mugsy_mapping_install_dir = ''
    output_directory = ''
    output_snps_file = ''
}

process call_snps {
    script:
    """
    ${params.bin_dir}/mugsy_callsnps --input_indexed_maf ${params.output_directory}/input_maf.idx --fasta ${params.fasta} --output_file ${params.output_snps_file} --mugsy_mapping_dir ${params.mugsy_mapping_install_dir}
    """
}

process convert_to_VCF {
    script:
    """
    ${params.bin_dir}/clovr_snps_to_vcf --snp_file ${params.output_snps_file} --output_dir ${params.output_directory}
    """
}

workflow {
    // Serial execution chain
    call_snps()
    convert_to_VCF()
}
