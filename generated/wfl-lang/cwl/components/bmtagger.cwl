cwlVersion: v1.2
class: CommandLineTool
id: bmtagger
label: bmtagger
doc: |
  none
  Classification: alignment / pairwise
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
  reference_bitmask:
    type: string?
    doc: REFERENCE_BITMASK parameter
  reference_srprism:
    type: string?
    doc: REFERENCE_SRPRISM parameter
  input_format:
    type: string?
    doc: INPUT_FORMAT parameter
  input_class:
    type: string?
    doc: INPUT_CLASS parameter

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
