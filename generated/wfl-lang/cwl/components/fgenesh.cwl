cwlVersion: v1.2
class: CommandLineTool
id: fgenesh
label: fgenesh
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [fgenesh]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  parameter_file:
    type: string?
    doc: PARAMETER_FILE parameter

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
