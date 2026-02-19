cwlVersion: v1.2
class: CommandLineTool
id: bcpconverter
label: bcpconverter
doc: |
  Ergatis component: bcpconverter
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
  input_format:
    type: string?
    doc: INPUT_FORMAT parameter
  input_file_extension:
    type: string?
    doc: INPUT_FILE_EXTENSION parameter
  indir:
    type: string?
    doc: INDIR parameter
  table:
    type: string?
    doc: TABLE parameter

outputs:
  bcp_output:
    type: File
    outputBinding:
      glob: "*.bcp"
    doc: bcp format output
