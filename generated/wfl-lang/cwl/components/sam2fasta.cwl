cwlVersion: v1.2
class: CommandLineTool
id: sam2fasta
label: sam2fasta
doc: |
  Lateral Genome Transfer sam2fasta converter
  Classification: LGT
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [UNKNOWN]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  fastq:
    type: string?
    doc: FASTQ parameter
  hlgt:
    type: string?
    doc: HLGT parameter
  host:
    type: string?
    doc: HOST parameter
  combine_mates:
    type: string?
    doc: COMBINE_MATES parameter
  paired:
    type: int?
    default: 1
    doc: PAIRED parameter
  assume_uniq:
    type: string?
    doc: ASSUME_UNIQ parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
