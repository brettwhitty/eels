cwlVersion: v1.2
class: CommandLineTool
id: lgt_create_validated_bam
label: lgt_create_validated_bam
doc: |
  Validate the LGT Finder results and create a BAM file
  Classification: LGT
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mkdir]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  lgt_hits:
    type: string?
    doc: LGT_HITS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
