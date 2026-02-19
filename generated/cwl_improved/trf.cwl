cwlVersion: v1.2
class: CommandLineTool
id: trf
label: trf
doc: |
  none
  Classification: feature prediction / tRNAs
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [trf_wrapper]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  match:
    type: int?
    default: 2
    doc: MATCH parameter
  mismatch:
    type: int?
    default: 7
    doc: MISMATCH parameter
  delta:
    type: int?
    default: 7
    doc: DELTA parameter
  pm:
    type: int?
    default: 80
    doc: PM parameter
  pi:
    type: int?
    default: 10
    doc: PI parameter
  minscore:
    type: int?
    default: 50
    doc: MINSCORE parameter
  maxperiod:
    type: int?
    default: 500
    doc: MAXPERIOD parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
