cwlVersion: v1.2
class: CommandLineTool
id: clean_fasta
label: clean_fasta
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mkdir]

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
  nucleotide:
    type: string?
    doc: NUCLEOTIDE parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
