cwlVersion: v1.2
class: CommandLineTool
id: ncbi-blastall
label: ncbi-blastall
doc: |
  none
  Classification: alignment / pairwise
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [ncbi-blastall]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter
  expect:
    type: float?
    default: 1e-5
    doc: EXPECT parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  btab_output:
    type: File
    outputBinding:
      glob: "*.btab"
    doc: btab format output
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
