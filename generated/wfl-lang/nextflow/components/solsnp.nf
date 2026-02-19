#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: solsnp
// Generated from Ergatis component JSON by EELS

params {
    component_name = ''
    filter = ''
    group_number = ''
    iterator_name = ''
    i_file_base = ''
    i_file_path = ''
    min_base_quality = ''
    min_coverage = ''
    output_directory = ''
    ref_sequence = ''
    solsnp_exec = ''
}

process solsnp {
    script:
    """
    java -jar ${params.solsnp_exec} INPUT=${params.i_file_path} OUTPUT=${params.output_directory}/${params.iterator_name}/g${params.group_number}/${params.i_file_base}.${params.component_name}.vcf STRAND_MODE=None REFERENCE_SEQUENCE=${params.ref_sequence} FILTER=${params.filter} MINIMUM_BASE_QUALITY=${params.min_base_quality} MINIMUM_MAPQ=20 OUTPUT_FORMAT=VCF PLOIDY=Haploid MINIMUM_COVERAGE=${params.min_coverage} VALIDATION_STRINGENCY=SILENT SUMMARY=false CALCULATE_ALLELIC_BALANCE=false CALL_BIAS=0.0 MAXIMUM_COVERAGE=0 OUTPUT_MODE=Variants MAX_MATE_DISTANCE=2147483647 MIN_MATE_DISTANCE=0 GENERATE_GENOTYPES=true MIN_ALIGNMENT_SCORE=0 TMP_DIR=/tmp/ VERBOSITY=INFO QUIET=false COMPRESSION_LEVEL=5 MAX_RECORDS_IN_RAM=500000 CREATE_INDEX=false CREATE_MD5_FILE=false \
        2>{{OUTPUT_DIRECTORY}}/{{ITERATOR_NAME}}/g{{GROUP_NUMBER}}/{{I_FILE_BASE}}.{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    solsnp()
}
