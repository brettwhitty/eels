cwlVersion: v1.2
class: CommandLineTool
id: translate_sequence
label: translate_sequence
doc: |
  none
  Classification: sequence / manipulation
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [translate_sequence]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  table:
    type: string?
    doc: TABLE parameter
  frame:
    type: int?
    default: 1
    doc: FRAME parameter
  multifasta_output:
    type: string?
    doc: MULTIFASTA_OUTPUT parameter
  seqs_per_fasta:
    type: int?
    default: 100
    doc: SEQS_PER_FASTA parameter
  regions:
    type: string?
    doc: REGIONS parameter
  project_name:
    type: string?
    default: "$;PROJECT$;"
    doc: PROJECT_NAME parameter
  cleanup:
    type: string?
    doc: CLEANUP parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  fsa_output:
    type: File
    outputBinding:
      glob: "*.fsa"
    doc: fsa format output
