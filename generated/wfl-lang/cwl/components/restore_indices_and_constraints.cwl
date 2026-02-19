cwlVersion: v1.2
class: CommandLineTool
id: restore_indices_and_constraints
label: restore_indices_and_constraints
doc: |
  none
  Classification: database / manipulation
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [UNKNOWN]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  database:
    type: string?
    default: "$;PROJECT$;"
    doc: DATABASE parameter
  server:
    type: string?
    doc: SERVER parameter
  rdbms:
    type: string?
    default: "sybase"
    doc: RDBMS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
