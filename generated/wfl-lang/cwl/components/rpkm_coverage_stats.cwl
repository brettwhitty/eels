cwlVersion: v1.2
class: CommandLineTool
id: rpkm_coverage_stats
label: rpkm_coverage_stats
doc: |
  generates RPKM coverage stats for the given BAM alignment file
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [rpkm_coverage_stats]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  bedtools_bin_dir:
    type: string?
    default: "$;BEDTOOLS_BIN$;"
    doc: BEDTOOLS_BIN_DIR parameter
  samtools_bin_dir:
    type: string?
    default: "$;SAMTOOLS_BIN$;"
    doc: SAMTOOLS_BIN_DIR parameter
  feature_id:
    type: string?
    doc: FEATURE_ID parameter
  attribute_id:
    type: string?
    doc: ATTRIBUTE_ID parameter
  groupby_id:
    type: string?
    doc: GROUPBY_ID parameter
  other_args:
    type: string?
    default: "--v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
