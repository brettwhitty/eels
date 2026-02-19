#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: qiime_fastq_mothur_cnvr
// Generated from Ergatis component JSON by EELS

params {
    barcode_type = ''
    bin_dir = ''
    input_file_list = ''
    mapping_file = ''
    mothur_prefix = ''
    otheropts = ''
    output_directory = ''
}

process preprocess_input_data_for_split_libraries {
    script:
    """
    ${params.bin_dir}/prep_MiSeq_for_qiime.sh -f ${params.input_file_list} -o ${params.output_directory} -b ${params.bin_dir} \
        1>${params.output_directory}/prep.stdout \
        2>{{OUTPUT_DIRECTORY}}/prep.stderr
    """
}

process Validate_input_mapping_file {
    script:
    """
    ${params.bin_dir}/validate_mapfile.sh -m `cat ${params.mapping_file}` -o ${params.output_directory} \
        2>{{OUTPUT_DIRECTORY}}/mapping_corrected.stderr
    """
}

process split_libraries_for_QIIME___FastQ {
    script:
    """
    ${params.bin_dir}/split_libraries_fastq -m ${params.output_directory}/mapping_corrected.txt,${params.output_directory}/mapping_corrected.txt -i ${params.output_directory}/R1N_PE.fq,${params.output_directory}/R3N_PE.fq -o ${params.output_directory}/splitlibs/ -b ${params.output_directory}/barcode.fq,${params.output_directory}/barcode.fq --barcode_type ${params.barcode_type} ${params.otheropts} \
        1>${params.output_directory}/split_libraries.stdout \
        2>{{OUTPUT_DIRECTORY}}/split_libraries.stderr
    """
}

process create_input_files_for_mothur_components {
    script:
    """
    ${params.bin_dir}/qiime_to_mothur_meta.pl -f ${params.output_directory}/splitlibs/seqs.fna -m ${params.output_directory}/mapping_corrected.txt -p ${params.mothur_prefix} \
        1>${params.output_directory}/qiime2mothur.stdout \
        2>{{OUTPUT_DIRECTORY}}/qiime2mothur.stderr
    """
}

workflow {
    // Serial execution chain
    preprocess_input_data_for_split_libraries()
    Validate_input_mapping_file()
    split_libraries_for_QIIME___FastQ()
    create_input_files_for_mothur_components()
}
