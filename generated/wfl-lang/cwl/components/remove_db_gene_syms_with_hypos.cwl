cwlVersion: v1.2
class: CommandLineTool
id: remove_db_gene_syms_with_hypos
label: remove_db_gene_syms_with_hypos
doc: |
  Remove EC numbers and gene symbols that have hypothetical gene product names
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [remove_hypothetical_ec]

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
  update:
    type: int?
    default: 1
    doc: UPDATE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
