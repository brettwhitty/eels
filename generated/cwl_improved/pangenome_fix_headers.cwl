cwlVersion: v1.2
class: CommandLineTool
id: pangenome_fix_headers
label: pangenome_fix_headers
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [pangenome_fix_headers.sh]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  mapping_file:
    type: string?
    doc: MAPPING_FILE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
