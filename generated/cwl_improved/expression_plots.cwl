cwlVersion: v1.2
class: CommandLineTool
id: expression_plots
label: expression_plots
doc: |
  generates visualization PDF fie of image for given expression analysis results
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [expression_plots]

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
  lfc:
    type: string?
    doc: LFC parameter
  fdr:
    type: string?
    doc: FDR parameter
  gene_col:
    type: string?
    doc: GENE_COL parameter
  rpkm_col:
    type: string?
    doc: RPKM_COL parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
