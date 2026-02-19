cwlVersion: v1.2
class: CommandLineTool
id: RAPSearch2
label: RAPSearch2
doc: |
  none
  Classification: alignment / pairwise
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [RAPSearch2]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  expect:
    type: float?
    default: 1e-5
    doc: EXPECT parameter
  database_matches:
    type: int?
    default: 150
    doc: DATABASE_MATCHES parameter
  min_aln_length:
    type: string?
    doc: MIN_ALN_LENGTH parameter
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
  aln_output:
    type: File
    outputBinding:
      glob: "*.aln"
    doc: aln format output
  m8_output:
    type: File
    outputBinding:
      glob: "*.m8"
    doc: m8 format output
