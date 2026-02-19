cwlVersion: v1.2
class: CommandLineTool
id: samtools_alignment_stats
label: samtools_alignment_stats
doc: |
  generates samtools alignment stats for the given BAM alignment file
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [samtools_alignment_stats]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  samtools_bin_dir:
    type: string?
    default: "$;SAMTOOLS_BIN$;"
    doc: SAMTOOLS_BIN_DIR parameter
  other_args:
    type: string?
    default: "--v"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
