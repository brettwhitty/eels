cwlVersion: v1.2
class: CommandLineTool
id: fastx_quality_stats
label: fastx_quality_stats
doc: |
  generates quality statistics for input FastX file
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [fastx_quality_stats]

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
  other_args:
    type: string?
    default: "--z --v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
