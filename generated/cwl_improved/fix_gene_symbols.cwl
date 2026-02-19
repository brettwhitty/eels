cwlVersion: v1.2
class: CommandLineTool
id: fix_gene_symbols
label: fix_gene_symbols
doc: |
  Fix gene symbols by removing duplicates in database or provided .tbl file
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [fix_gene_symbols]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  server:
    type: string?
    default: "jabba"
    doc: SERVER parameter
  username:
    type: string?
    doc: USERNAME parameter
  password:
    type: string?
    doc: PASSWORD parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
