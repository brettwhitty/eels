#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: qiime_fasta_mothur_cnvr
// Generated from Ergatis component JSON by EELS

params {
    barcodes = ''
    bin_dir = ''
    input_file_list = ''
    mapping_file = ''
    maxambiguous = ''
    maximum_homopolymer_length = ''
    max_length = ''
    min_length = ''
    mothur_prefix = ''
    otheropts = ''
    output_directory = ''
    qual_file_list = ''
}

process preprocess_input_data_for_split_libraries {
    script:
    """
    ${params.bin_dir}/dataprep_dual16S.pl -m `cat ${params.mapping_file}` -f ${params.input_file_list} -q " ${params.qual_file_list} " -p ${params.output_directory}/Data
    """
}

process split_libraries_for_Qiime_workflows {
    script:
    """
    ${params.bin_dir}/split_libraries -m ${params.output_directory}/Data.processed.map -f ${params.output_directory}/Data.processed.fasta -q ${params.output_directory}/Data.processed.qual -o ${params.output_directory}/splitlibs/ -b ${params.barcodes} -l ${params.min_length} -L ${params.max_length} -H ${params.maximum_homopolymer_length} -a ${params.maxambiguous} ${params.otheropts}
    """
}

process create_input_files_for_mothur_components {
    script:
    """
    ${params.bin_dir}/qiime_to_mothur_meta.pl -f ${params.output_directory}/splitlibs/seqs.fna -m  ${params.output_directory}/Data.processed.map -p ${params.mothur_prefix}
    """
}

workflow {
    // Serial execution chain
    preprocess_input_data_for_split_libraries()
    split_libraries_for_Qiime_workflows()
    create_input_files_for_mothur_components()
}
