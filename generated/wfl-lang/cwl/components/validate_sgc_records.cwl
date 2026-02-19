cwlVersion: v1.2
class: CommandLineTool
id: validate_sgc_records
label: validate_sgc_records
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
  database_list:
    type: string?
    doc: DATABASE_LIST parameter
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
  email_list:
    type: string?
    doc: EMAIL_LIST parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
