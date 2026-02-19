cwlVersion: v1.2
class: CommandLineTool
id: mpileup
label: mpileup
doc: |
  samtools mpileup
  Classification: alignment
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
  other_mpileup_parameters:
    type: string?
    default: "-B -C50"
    doc: OTHER_MPILEUP_PARAMETERS parameter

outputs:
  mpileup_output:
    type: File
    outputBinding:
      glob: "*.mpileup"
    doc: mpileup format output
