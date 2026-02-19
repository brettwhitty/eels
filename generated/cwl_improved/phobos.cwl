cwlVersion: v1.2
class: CommandLineTool
id: phobos
label: phobos
doc: |
  none
  Classification: sequence / masking
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [phobos]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  search_mode:
    type: string?
    default: "imperfect"
    doc: SEARCH_MODE parameter
  indel_score:
    type: string?
    default: "-5"
    doc: INDEL_SCORE parameter
  mismatch_score:
    type: string?
    default: "-5"
    doc: MISMATCH_SCORE parameter
  minscore:
    type: int?
    default: 6
    doc: MINSCORE parameter
  minlength:
    type: string?
    doc: MINLENGTH parameter
  minunitlen:
    type: int?
    default: 1
    doc: MINUNITLEN parameter
  maxunitlen:
    type: int?
    default: 10
    doc: MAXUNITLEN parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

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
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
