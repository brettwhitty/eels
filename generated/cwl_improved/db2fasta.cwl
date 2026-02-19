cwlVersion: v1.2
class: CommandLineTool
id: db2fasta
label: db2fasta
doc: |
  none
  Classification: database / extraction
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
    default: "access"
    doc: USERNAME parameter
  password:
    type: string?
    default: "access"
    doc: PASSWORD parameter
  rdbms:
    type: string?
    default: "Sybase"
    doc: RDBMS parameter
  server:
    type: string?
    default: "SYBPROD"
    doc: SERVER parameter
  database:
    type: string?
    default: "$;PROJECT$;"
    doc: DATABASE parameter
  single:
    type: string?
    doc: SINGLE parameter
  schema:
    type: string?
    default: "chado"
    doc: SCHEMA parameter

outputs:
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
