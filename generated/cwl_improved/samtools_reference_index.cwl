cwlVersion: v1.2
class: CommandLineTool
id: samtools_reference_index
label: samtools_reference_index
doc: |
  generates samtools index for the given reference FastA file
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [samtools_reference_index]

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
