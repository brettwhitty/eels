cwlVersion: v1.2
class: CommandLineTool
id: find_homopolymers
label: find_homopolymers
doc: |
  none
  Classification: sequence / masking
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [find_homopolymers.pl]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  at_min_length:
    type: int?
    default: 8
    doc: AT_MIN_LENGTH parameter
  gc_min_length:
    type: int?
    default: 8
    doc: GC_MIN_LENGTH parameter

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
