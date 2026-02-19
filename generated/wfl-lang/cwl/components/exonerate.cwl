cwlVersion: v1.2
class: CommandLineTool
id: exonerate
label: exonerate
doc: |
  none
  Classification: alignment / pairwise
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [exonerate]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  model:
    type: string?
    default: "est2genome"
    doc: MODEL parameter
  other_opts:
    type: string?
    default: "--showtargetgff 1"
    doc: OTHER_OPTS parameter

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
