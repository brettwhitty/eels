cwlVersion: v1.2
class: CommandLineTool
id: fastx_trimming
label: fastx_trimming
doc: |
  generates trimmed FastX sequences for the given input FastX file
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [fastx_trimming]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  fastx_bin_dir:
    type: string?
    default: "$;FASTX_BIN$;"
    doc: FASTX_BIN_DIR parameter
  quality_string:
    type: int?
    default: 33
    doc: QUALITY_STRING parameter
  first_base:
    type: string?
    doc: FIRST_BASE parameter
  last_base:
    type: string?
    doc: LAST_BASE parameter
  other_args:
    type: string?
    default: "--qs --z --v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
