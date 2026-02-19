cwlVersion: v1.2
class: CommandLineTool
id: mugsycog
label: mugsycog
doc: |
  none
  Classification: clustering
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [UNKNOWN]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  max_multi_alignment:
    type: int?
    default: 100
    doc: MAX_MULTI_ALIGNMENT parameter
  use_feature_ids_in_fasta:
    type: int?
    default: 1
    doc: USE_FEATURE_IDS_IN_FASTA parameter
  coverage:
    type: float?
    default: 0.7
    doc: COVERAGE parameter
  identity:
    type: float?
    default: 0.6
    doc: IDENTITY parameter
  query_coverage:
    type: string?
    doc: QUERY_COVERAGE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
