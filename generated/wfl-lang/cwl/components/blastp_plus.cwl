cwlVersion: v1.2
class: CommandLineTool
id: blastp_plus
label: blastp_plus
doc: |
  none
  Classification: alignment / pairwise
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [run_blast_plus]

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
  max_target_seqs:
    type: int?
    default: 150
    doc: MAX_TARGET_SEQS parameter
  other_opts:
    type: string?
    default: ""-task blastp ""
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
  m8_output:
    type: File
    outputBinding:
      glob: "*.m8"
    doc: m8 format output
