cwlVersion: v1.2
class: CommandLineTool
id: fastqc_stats
label: fastqc_stats
doc: |
  Generates stats on the fastq files used for input into an aligner
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [fastqc_stats]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  fastqc_bin_dir:
    type: string?
    default: "$;FASTQC_BIN$;"
    doc: FASTQC_BIN_DIR parameter
  other_parameters:
    type: string?
    doc: OTHER_PARAMETERS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
