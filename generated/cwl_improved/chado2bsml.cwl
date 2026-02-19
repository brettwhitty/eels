cwlVersion: v1.2
class: CommandLineTool
id: chado2bsml
label: chado2bsml
doc: |
  none
  Classification: database / extraction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mkdir]

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
  database_type:
    type: string?
    default: "sybase"
    doc: DATABASE_TYPE parameter
  server:
    type: string?
    doc: SERVER parameter
  ignore_go:
    type: string?
    doc: IGNORE_GO parameter
  ignore_evcodes:
    type: string?
    doc: IGNORE_EVCODES parameter
  ignore_non_go:
    type: string?
    doc: IGNORE_NON_GO parameter
  polypeptides_only:
    type: string?
    doc: POLYPEPTIDES_ONLY parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
