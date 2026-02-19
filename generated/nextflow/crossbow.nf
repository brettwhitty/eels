#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: crossbow
// Generated from Ergatis component JSON by EELS

params {
    crossbow_exec = ''
    crossbow_opts = ''
    hadoop_exec = ''
    input_file = ''
    output_directory = ''
    pipelineid = ''
    reference_jar = ''
}

process upload_input_file_to_HFS {
    script:
    """
    ${params.hadoop_exec} fs -put ${params.input_file} /users/clovr/ergatis/${params.pipelineid}/input.manifest
    """
}

process create_reference_directory_on_HFS {
    script:
    """
    ${params.hadoop_exec} fs -mkdir /users/clovr/ergatis/${params.pipelineid}/reference/
    """
}

process upload_reference_jar_to_HFS {
    script:
    """
    ${params.hadoop_exec} fs -put ${params.reference_jar} /users/clovr/ergatis/${params.pipelineid}/reference/reference.jar
    """
}

process crossbow {
    script:
    """
    ${params.crossbow_exec} ${params.crossbow_opts} --input hdfs:///users/clovr/ergatis/${params.pipelineid}/input.manifest --output hdfs:///users/clovr/ergatis/${params.pipelineid}/output --reference hdfs:///users/clovr/ergatis/${params.pipelineid}/reference/reference.jar \
        1>${params.output_directory}/${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.stderr
    """
}

process download_crossbow_output {
    script:
    """
    ${params.hadoop_exec} fs -get /users/clovr/ergatis/${params.pipelineid}/output/*.gz ${params.output_directory}/
    """
}

workflow {
    // Serial execution chain
    upload_input_file_to_HFS()
    create_reference_directory_on_HFS()
    upload_reference_jar_to_HFS()
    crossbow()
    download_crossbow_output()
}
