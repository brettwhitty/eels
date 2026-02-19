cwlVersion: v1.2
class: CommandLineTool
id: antigenic
label: antigenic
doc: |
  none
  Classification: functional prediction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [antigenic]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  min_length:
    type: string?
    doc: MIN_LENGTH parameter

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
