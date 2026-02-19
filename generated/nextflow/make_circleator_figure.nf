#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Component: make_circleator_figure
// Generated from Ergatis component JSON by EELS

params {
    bin_dir = ''
    circleator_path = ''
    config_dir = ''
    genbank_dir = ''
    output_directory = ''
    output_format = ''
    output_height = ''
    output_width = ''
    rasterizer_path = ''
    svg_basename = ''
}

process make_circleator_figure {
    script:
    """
    ${params.bin_dir}/make_circleator_figure --circleator_path ${params.circleator_path} --rasterizer_path ${params.rasterizer_path} --config_dir ${params.config_dir} --genbank_dir ${params.genbank_dir} --svg_file ${params.svg_basename} --output_dir ${params.output_directory} --output_format ${params.output_format} --output_width ${params.output_width} --output_height ${params.output_height} \
        1>${params.output_directory}/${params.component_name}.stdout \
        2>{{OUTPUT_DIRECTORY}}/{{COMPONENT_NAME}}.stderr
    """
}

workflow {
    // Serial execution chain
    make_circleator_figure()
}
