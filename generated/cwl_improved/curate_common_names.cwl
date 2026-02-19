cwlVersion: v1.2
class: CommandLineTool
id: curate_common_names
label: curate_common_names
doc: |
  Curate gene product names to meet certain standards
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [curate_common_names]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  host:
    type: string?
    doc: HOST parameter
  username:
    type: string?
    doc: USERNAME parameter
  password:
    type: string?
    doc: PASSWORD parameter
  password_file:
    type: string?
    doc: PASSWORD_FILE parameter
  no_change:
    type: string?
    doc: NO_CHANGE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
