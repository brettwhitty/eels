cwlVersion: v1.2
class: CommandLineTool
id: nucmer-delta-filter
label: nucmer-delta-filter
doc: |
  none
  Classification: alignment
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
  filter_opts:
    type: string?
    doc: FILTER_OPTS parameter

outputs:
  delta_output:
    type: File
    outputBinding:
      glob: "*.delta"
    doc: delta format output
