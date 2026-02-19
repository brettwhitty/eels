cwlVersion: v1.2
class: CommandLineTool
id: glk2bsml
label: glk2bsml
doc: |
  none
  Classification: database / extraction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [dtdValid.pl]

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
  id_gen_version:
    type: string?
    doc: ID_GEN_VERSION parameter

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
