cwlVersion: v1.2
class: CommandLineTool
id: mumi-reduce
label: mumi-reduce
doc: |
  de-redundify a collection of reference sequences via pairwise alignment
  Classification: sequence / manipulation
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
  cluster_threshold:
    type: float?
    default: 0.3
    doc: CLUSTER_THRESHOLD parameter
  min_mum:
    type: int?
    default: 19
    doc: MIN_MUM parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
