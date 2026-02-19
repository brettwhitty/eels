cwlVersion: v1.2
class: CommandLineTool
id: mothur_tree_shared
label: mothur_tree_shared
doc: |
  none
  Classification: phylogeny
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
    default: "[ rabund|sabund|list|shared ]"
    doc: OTU_FORMAT parameter
  read_otu_options:
    type: string?
    doc: READ_OTU_OPTIONS parameter
  config_options:
    type: string?
    doc: CONFIG_OPTIONS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
