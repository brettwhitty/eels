cwlVersion: v1.2
class: CommandLineTool
id: mothur_trim_seqs
label: mothur_trim_seqs
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
  maximum_length:
    type: string?
    doc: MAXIMUM_LENGTH parameter
  minimum_length:
    type: string?
    doc: MINIMUM_LENGTH parameter
  flip:
    type: string?
    doc: FLIP parameter
  maximum_homopolymer_length:
    type: string?
    doc: MAXIMUM_HOMOPOLYMER_LENGTH parameter
  maximum_ambiguous_bases:
    type: string?
    doc: MAXIMUM_AMBIGUOUS_BASES parameter
  q_average:
    type: string?
    doc: Q_AVERAGE parameter
  config_options:
    type: string?
    doc: CONFIG_OPTIONS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
