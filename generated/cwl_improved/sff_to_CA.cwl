cwlVersion: v1.2
class: CommandLineTool
id: sff_to_CA
label: sff_to_CA
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
  library:
    type: string?
    doc: LIBRARY parameter
  linker:
    type: string?
    doc: LINKER parameter
  trim:
    type: string?
    default: "hard"
    doc: TRIM parameter
  clear:
    type: int?
    default: 454
    doc: CLEAR parameter
  insert_size:
    type: string?
    doc: INSERT_SIZE parameter

outputs:
  frg_output:
    type: File
    outputBinding:
      glob: "*.frg"
    doc: frg format output
