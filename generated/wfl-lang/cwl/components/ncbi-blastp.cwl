cwlVersion: v1.2
class: CommandLineTool
id: ncbi-blastp
label: ncbi-blastp
doc: |
  none
  Classification: alignment / pairwise
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [ncbi-blastp]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  matrix:
    type: string?
    default: "BLOSUM62"
    doc: MATRIX parameter
  expect:
    type: float?
    default: 1e-5
    doc: EXPECT parameter
  filter:
    type: string?
    default: "T"
    doc: FILTER parameter
  database_matches:
    type: int?
    default: 150
    doc: DATABASE_MATCHES parameter
  descriptions:
    type: int?
    default: 150
    doc: DESCRIPTIONS parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

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
