#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: mugsycog_distributed_work
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    bsml_file_list = ''
    coverage = ''
    fixed_mugsy_alignment = ''
    genomic_fasta_copy = ''
    genomic_multifasta = ''
    identity = ''
    max_multi_alignment = ''
    mugsy_alignment = ''
    mugsy_index = ''
    mugsy_mapping_install_dir = ''
    mugsy_map_file = ''
    output_directory = ''
    query_coverage = ''
    transform_dir = ''
    use_feature_ids_in_fasta = ''
}

process create_transform_directory {
    script:
    """
    mkdir -p -m 777 ${params.transform_dir}
    """
}

process add_mugsymap_features_to_mugsy_index {
    script:
    """
    ${params.mugsy_mapping_install_dir}/featureindex.pl ${params.mugsy_index} stdin ${params.mugsy_map_file} \
        1>${params.output_directory}/featuresindex.out
    """
}

process fix_maf {
    script:
    """
    perl -ne 's/^s\s+[^\.]+\.(\S+)/s $1/;print'  stdin ${params.mugsy_alignment} \
        1>${params.fixed_mugsy_alignment}
    """
}

process index_alignment {
    script:
    """
    ${params.mugsy_mapping_install_dir}/mafindex.pl ${params.mugsy_index} stdin ${params.fixed_mugsy_alignment} \
        1>${params.output_directory}/mafindex.stdout
    """
}

process copy_fasta {
    script:
    """
    cp ${params.genomic_multifasta} ${params.genomic_fasta_copy}
    """
}

process map_features_to_alignment {
    script:
    """
    ${params.mugsy_mapping_install_dir}/mapfeatures.pl ${params.mugsy_index} ${params.genomic_fasta_copy} --skipframeshifts --map_file ${params.mugsy_map_file} --coverage ${params.coverage} --identity ${params.identity} --query_coverage ${params.query_coverage} --reportedits 0 --cogformat ${params.output_directory}/mugsyoutput.cog \
        1>${params.output_directory}/mugsyoutput.raw \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.stderr
    """
}

process fix_mugsycog_output_file {
    script:
    """
    ${params.bin_dir}/transform_mugsycog --map_file ${params.mugsy_map_file} --mugsycog ${params.output_directory}/mugsyoutput.cog --output_file ${params.transform_dir}/mugsyoutput_transformed.cog \
        1>${params.transform_dir}/${params.component_name}_transform.stdout \
        2>{{TRANSFORM_DIR}}/{{COMPONENT_NAME}}_transform.stderr
    """
}

process cogs2fasta {
    script:
    """
    ${params.bin_dir}/CogProteinFasta --cogFile ${params.output_directory}/mugsyoutput.cog --map_file ${params.mugsy_map_file} --transformDir ${params.transform_dir}/fasta/ --bsmlModelList ${params.bsml_file_list} --outputDir ${params.output_directory}/fasta/ --maxCogSeqCount ${params.max_multi_alignment} --use_feature_ids_in_fasta '${params.use_feature_ids_in_fasta}' \
        1>${params.tmp_dir}/CogProteinFasta.stdout \
        2>{{TMP_DIR}}/CogProteinFasta.stderr
    """
}

workflow {
    // Serial execution chain
    create_transform_directory()
    add_mugsymap_features_to_mugsy_index()
    fix_maf()
    index_alignment()
    copy_fasta()
    map_features_to_alignment()
    fix_mugsycog_output_file()
    cogs2fasta()
}
