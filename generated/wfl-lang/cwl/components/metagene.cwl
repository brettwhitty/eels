cwlVersion: v1.2
class: CommandLineTool
id: metagene
label: metagene
doc: |
  none
  Classification: feature prediction / ORFs
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [metagene]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  num_seqs:
    type: int?
    default: 1000
    doc: NUM_SEQS parameter
  cutoff:
    type: int?
    default: 180
    doc: CUTOFF parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
  tbl_output:
    type: File
    outputBinding:
      glob: "*.tbl"
    doc: tbl format output
  gbk_output:
    type: File
    outputBinding:
      glob: "*.gbk"
    doc: gbk format output
