#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: amoscmp
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    quality_file_list = ''
    reference_genome_map = ''
    sequence_file_list = ''
    tmp_dir = ''
}

process create_amoscmp_iterator_list {
    script:
    """
    ${params.bin_dir}/create_amoscmp_iterator_list --sequence_list ${params.sequence_file_list} --qual_list ${params.quality_file_list} --reference_map ${params.reference_genome_map} --output ${params.tmp_dir}/amoscmp.list --log ${params.tmp_dir}/create_amoscmp_iterator_list.log --debug 4 \
        1>${params.tmp_dir}/create_amoscmp_iterator_list.stdout \
        2>{{TMP_DIR}}/create_amoscmp_iterator_list.stderr
    """
}

workflow {
    // Serial execution chain
    create_amoscmp_iterator_list()
}
