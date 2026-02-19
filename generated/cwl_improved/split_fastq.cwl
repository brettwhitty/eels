cwlVersion: v1.2
class: CommandLineTool
id: split_fastq
label: split_fastq
doc: |
  none
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [split_fastq]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  seq_number:
    type: int?
    default: 20000000
    doc: SEQ_NUMBER parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
