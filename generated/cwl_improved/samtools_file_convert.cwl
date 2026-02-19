cwlVersion: v1.2
class: CommandLineTool
id: samtools_file_convert
label: samtools_file_convert
doc: |
  converts alignment files between SAM and BAM file formats
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [samtools_file_convert]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  reference_fasta:
    type: string?
    doc: REFERENCE_FASTA parameter
  samtools_bin_dir:
    type: string?
    default: "$;SAMTOOLS_BIN$;"
    doc: SAMTOOLS_BIN_DIR parameter
  samtools_view_parameters:
    type: string?
    doc: SAMTOOLS_VIEW_PARAMETERS parameter
  samtools_sort_parameters:
    type: string?
    doc: SAMTOOLS_SORT_PARAMETERS parameter
  other_args:
    type: string?
    default: "--v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
