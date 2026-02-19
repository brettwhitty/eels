cwlVersion: v1.2
class: CommandLineTool
id: mothur_summary
label: mothur_summary
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mothur]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  summary_type:
    type: string?
    default: "[ single|shared ]"
    doc: SUMMARY_TYPE parameter
  otu_format:
    type: string?
    default: "[ list|rabund|sabund|shared ]"
    doc: OTU_FORMAT parameter
  config_options:
    type: string?
    doc: CONFIG_OPTIONS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
