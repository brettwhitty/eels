cwlVersion: v1.2
class: CommandLineTool
id: rotate_molecule
label: rotate_molecule
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
  username:
    type: string?
    doc: USERNAME parameter
  password:
    type: string?
    doc: PASSWORD parameter
  database:
    type: string?
    doc: DATABASE parameter
  server:
    type: string?
    doc: SERVER parameter
  assembly:
    type: string?
    doc: ASSEMBLY parameter
  coord:
    type: string?
    doc: COORD parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
