cwlVersion: v1.2
class: CommandLineTool
id: mothur_read_otu
label: mothur_read_otu
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
  otu_format:
    type: string?
    default: "[ list|sabund|rabund|shared ]"
    doc: OTU_FORMAT parameter
  label:
    type: string?
    doc: LABEL parameter
  config_options:
    type: string?
    doc: CONFIG_OPTIONS parameter

outputs:
  rabund_output:
    type: File
    outputBinding:
      glob: "*.rabund"
    doc: rabund format output
  shared_output:
    type: File
    outputBinding:
      glob: "*.shared"
    doc: shared format output
