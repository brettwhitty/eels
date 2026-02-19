cwlVersion: v1.2
class: CommandLineTool
id: bsml2gff3
label: bsml2gff3
doc: |
  none
  Classification: file / conversion
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
  gbrowse:
    type: string?
    doc: GBROWSE parameter
  gbrowse_dbxref_map:
    type: string?
    doc: GBROWSE_DBXREF_MAP parameter

outputs:
  gff3_output:
    type: File
    outputBinding:
      glob: "*.gff3"
    doc: gff3 format output
