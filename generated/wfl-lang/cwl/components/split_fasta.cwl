cwlVersion: v1.2
class: CommandLineTool
id: split_fasta
label: split_fasta
doc: |
  none
  Classification: sequence / manipulation
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [split_fasta]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  fragment_length:
    type: string?
    doc: FRAGMENT_LENGTH parameter
  overlap_length:
    type: string?
    doc: OVERLAP_LENGTH parameter
  file_numbering:
    type: string?
    default: "incremental"
    doc: FILE_NUMBERING parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
