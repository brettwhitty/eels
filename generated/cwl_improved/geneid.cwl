cwlVersion: v1.2
class: CommandLineTool
id: geneid
label: geneid
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [geneid]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  param_file:
    type: string?
    doc: PARAM_FILE parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  gff3_output:
    type: File
    outputBinding:
      glob: "*.gff3"
    doc: gff3 format output
