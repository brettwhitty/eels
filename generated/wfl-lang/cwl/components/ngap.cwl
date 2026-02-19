cwlVersion: v1.2
class: CommandLineTool
id: ngap
label: ngap
doc: |
  none
  Classification: sequence / properties
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [ngap]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
