cwlVersion: v1.2
class: CommandLineTool
id: seg
label: seg
doc: |
  none
  Classification: sequence / masking
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [seg]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
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
