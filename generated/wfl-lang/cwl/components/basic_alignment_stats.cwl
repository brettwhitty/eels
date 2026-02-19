cwlVersion: v1.2
class: CommandLineTool
id: basic_alignment_stats
label: basic_alignment_stats
doc: |
  runs samtools idxstats and samtools flagstat on a sorted bam file and index to generate basic read alignment information
  Classification: alignment
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [basic_alignment_stats]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
