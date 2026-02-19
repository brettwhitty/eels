#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: tag_data
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    flatten = ''
    input = ''
    map_file = ''
    pipelineid = ''
    pipeline_id = ''
    pipeline_name = ''
    repository_root = ''
    tmp_dir = ''
}

process tarring_workflow_xml_paths {
    script:
    """
    tar -czf ${params.tmp_dir}/${params.pipeline_name}_workflow_xml.tar.gz $(find /mnt/projects/clovr/workflow/runtime/*/${params.pipelineid}_* /mnt/projects/clovr/workflow/runtime/pipeline/${params.pipelineid} -type d) || true
    """
}

process select_files_to_tag {
    script:
    """
    printf "${params.input}" > ${params.map_file}
    """
}

process tag_data {
    script:
    """
    ${params.bin_dir}/tag_data --map_file ${params.map_file} --flatten ${params.flatten} --repository_root ${params.repository_root} --pipeline_id ${params.pipeline_id} --pipeline_name ${params.pipeline_name} --log_file ${params.tmp_dir}/tag_data_ergatis.log --debug 4 \
        1>${params.output_directory}/tag_data.stdout \
        2>{{OUTPUT_DIRECTORY}}/tag_data.stderr
    """
}

workflow {
    // Serial execution chain
    tarring_workflow_xml_paths()
    select_files_to_tag()
    tag_data()
}
