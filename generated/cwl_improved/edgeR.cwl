cwlVersion: v1.2
class: CommandLineTool
id: edgeR
label: edgeR
doc: |
  generates edgeR analysis for given sample info and counts filelist
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [edgeR]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  annotation_file:
    type: string?
    doc: ANNOTATION_FILE parameter
  r_bin_dir:
    type: string?
    default: "$;R_BIN$;"
    doc: R_BIN_DIR parameter
  r_params:
    type: string?
    doc: R_PARAMS parameter
  r_script:
    type: string?
    default: "$;R_SCRIPT_PATH$;"
    doc: R_SCRIPT parameter
  other_args:
    type: string?
    default: "--v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
