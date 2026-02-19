cwlVersion: v1.2
class: CommandLineTool
id: bam_merge
label: bam_merge
doc: |
  none
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [bam_merge]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  samtools_bin:
    type: string?
    default: "/usr/local/bin"
    doc: SAMTOOLS_BIN parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
