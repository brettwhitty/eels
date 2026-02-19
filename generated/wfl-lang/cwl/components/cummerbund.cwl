cwlVersion: v1.2
class: CommandLineTool
id: cummerbund
label: cummerbund
doc: |
  generates visualization PDF and png image for given cuffdiff analysis results
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [cummerbund]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
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
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
