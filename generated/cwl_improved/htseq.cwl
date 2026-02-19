cwlVersion: v1.2
class: CommandLineTool
id: htseq
label: htseq
doc: |
  generates htseq alignment counts for the given SAM alignment file
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [htseq]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  python_bin_dir:
    type: string?
    default: "$;PYTHON_BIN$;"
    doc: PYTHON_BIN_DIR parameter
  python_lib_dir:
    type: string?
    default: "$;PYTHON_LIB$;"
    doc: PYTHON_LIB_DIR parameter
  mode:
    type: string?
    default: "union"
    doc: MODE parameter
  type:
    type: string?
    default: "exon"
    doc: TYPE parameter
  min_qual:
    type: string?
    doc: MIN_QUAL parameter
  stranded:
    type: string?
    default: "no"
    doc: STRANDED parameter
  attribute_id:
    type: string?
    default: "gene_id"
    doc: ATTRIBUTE_ID parameter
  other_params:
    type: string?
    doc: OTHER_PARAMS parameter
  other_args:
    type: string?
    default: "--v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
