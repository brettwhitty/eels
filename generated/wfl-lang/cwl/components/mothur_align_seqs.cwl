cwlVersion: v1.2
class: CommandLineTool
id: mothur_align_seqs
label: mothur_align_seqs
doc: |
  none
  Classification: alignment
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
  search_algorithm:
    type: string?
    default: "[ kmer|blast|suffix ]"
    doc: SEARCH_ALGORITHM parameter
  ksize:
    type: int?
    default: 8
    doc: KSIZE parameter
  align_algorithm:
    type: string?
    default: "[ needleman|gotoh|blastn ]"
    doc: ALIGN_ALGORITHM parameter
  match_value:
    type: int?
    default: 1
    doc: MATCH_VALUE parameter
  mismatch_value:
    type: string?
    default: "-1"
    doc: MISMATCH_VALUE parameter
  gapopen_value:
    type: string?
    default: "-2"
    doc: GAPOPEN_VALUE parameter
  gapextend_value:
    type: string?
    default: "-1"
    doc: GAPEXTEND_VALUE parameter
  flip:
    type: string?
    default: "t"
    doc: FLIP parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
