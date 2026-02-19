cwlVersion: v1.2
class: CommandLineTool
id: update_ec_numbers
label: update_ec_numbers
doc: |
  Update EC numbers in the database
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [update_ec_numbers]

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
  ec_dat_file:
    type: string?
    default: "/local/db/expasy/enzyme/latest/enzyme.dat"
    doc: EC_DAT_FILE parameter
  no_change:
    type: string?
    doc: NO_CHANGE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
