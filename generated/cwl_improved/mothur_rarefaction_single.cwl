cwlVersion: v1.2
class: CommandLineTool
id: mothur_rarefaction_single
label: mothur_rarefaction_single
doc: |
  none
  Classification: unclassified
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
  otu_format:
    type: string?
    default: "[ rabund|sabund|list ]"
    doc: OTU_FORMAT parameter
  config_options:
    type: string?
    doc: CONFIG_OPTIONS parameter

outputs:
  rarefaction_output:
    type: File
    outputBinding:
      glob: "*.rarefaction"
    doc: rarefaction format output
