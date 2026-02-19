cwlVersion: v1.2
class: CommandLineTool
id: gff3_to_annotab
label: gff3_to_annotab
doc: |
  none
  Classification: file / conversion
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [gff3_to_annotab]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  type:
    type: string?
    default: "cds"
    doc: TYPE parameter
  id_attr:
    type: string?
    doc: ID_ATTR parameter
  parse_go:
    type: int?
    default: 1
    doc: PARSE_GO parameter
  parse_ec:
    type: int?
    default: 1
    doc: PARSE_EC parameter
  parse_gene_symbol:
    type: int?
    default: 1
    doc: PARSE_GENE_SYMBOL parameter

outputs:
  annotab_output:
    type: File
    outputBinding:
      glob: "*.annotab"
    doc: annotab format output
