cwlVersion: v1.2
class: CommandLineTool
id: update_euk_model_sequences
label: update_euk_model_sequences
doc: |
  none
  Classification: database modification
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [deriveCDSSequences]

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
    default: "access"
    doc: USERNAME parameter
  password:
    type: string?
    default: "access"
    doc: PASSWORD parameter
  server:
    type: string?
    default: "SYBTIGR"
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
