cwlVersion: v1.2
class: CommandLineTool
id: mothur_collect_single
label: mothur_collect_single
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
  read_otu_options:
    type: string?
    doc: READ_OTU_OPTIONS parameter
  config_options:
    type: string?
    doc: CONFIG_OPTIONS parameter

outputs:
  sobs_output:
    type: File
    outputBinding:
      glob: "*.sobs"
    doc: sobs format output
  simpson_output:
    type: File
    outputBinding:
      glob: "*.simpson"
    doc: simpson format output
  shannon_output:
    type: File
    outputBinding:
      glob: "*.shannon"
    doc: shannon format output
  np_shannon_output:
    type: File
    outputBinding:
      glob: "*.np_shannon"
    doc: np_shannon format output
  jack_output:
    type: File
    outputBinding:
      glob: "*.jack"
    doc: jack format output
  chao_output:
    type: File
    outputBinding:
      glob: "*.chao"
    doc: chao format output
  ace_output:
    type: File
    outputBinding:
      glob: "*.ace"
    doc: ace format output
