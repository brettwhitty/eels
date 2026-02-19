cwlVersion: v1.2
class: CommandLineTool
id: genscan
label: genscan
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [genscan]

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
