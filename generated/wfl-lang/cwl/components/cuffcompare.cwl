cwlVersion: v1.2
class: CommandLineTool
id: cuffcompare
label: cuffcompare
doc: |
  generates cuffcompare analysis for the given Cufflinks GTF file
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [cuffcompare]

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
  prefix:
    type: string?
    default: "cuffcmp"
    doc: PREFIX parameter
  cufflinks_bin_dir:
    type: string?
    default: "$;CUFFCOMPARE_BIN$;"
    doc: CUFFLINKS_BIN_DIR parameter
  other_params:
    type: string?
    default: "-R"
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
