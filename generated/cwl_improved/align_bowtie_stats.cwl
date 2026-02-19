cwlVersion: v1.2
class: CommandLineTool
id: align_bowtie_stats
label: align_bowtie_stats
doc: |
  Calculates alignment statistics for Tophat Alignment
  Classification: RNA-Seq
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [align_bowtie_stats]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  other_parameters:
    type: string?
    doc: OTHER_PARAMETERS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
