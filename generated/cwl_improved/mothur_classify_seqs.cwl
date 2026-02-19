cwlVersion: v1.2
class: CommandLineTool
id: mothur_classify_seqs
label: mothur_classify_seqs
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
  config_options:
    type: string?
    doc: CONFIG_OPTIONS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
