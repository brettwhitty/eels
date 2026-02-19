cwlVersion: v1.2
class: CommandLineTool
id: muscle
label: muscle
doc: |
  Ergatis component: muscle
  Classification: alignment / multiple
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [cp]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter
  analysis_conf:
    type: string?
    default: "$;REPOSITORY_ROOT$;/workflow/runtime/$;COMPONENT_NAME$;/$;PIPELINEID$;_$;OUTPUT_TOKEN$;/$;COMPONENT_NAME$;.$;OUTPUT_TOKEN$;.final.config"
    doc: ANALYSIS_CONF parameter
  description:
    type: string?
    default: "none"
    doc: DESCRIPTION parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
