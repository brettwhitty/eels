cwlVersion: v1.2
class: CommandLineTool
id: bsml2interevidence_fasta
label: bsml2interevidence_fasta
doc: |
  none
  Classification: alignment / pairwise
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [UNKNOWN]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  length_cutoff:
    type: int?
    default: 100
    doc: LENGTH_CUTOFF parameter
  evidence_list:
    type: string?
    doc: EVIDENCE_LIST parameter

outputs:
  fsa_output:
    type: File
    outputBinding:
      glob: "*.fsa"
    doc: fsa format output
