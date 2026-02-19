cwlVersion: v1.2
class: CommandLineTool
id: mothur_unique_seqs
label: mothur_unique_seqs
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
  config_options:
    type: string?
    doc: CONFIG_OPTIONS parameter

outputs:
  names_output:
    type: File
    outputBinding:
      glob: "*.names"
    doc: names format output
