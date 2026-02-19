cwlVersion: v1.2
class: CommandLineTool
id: uclust
label: uclust
doc: |
  Ergatis component: uclust
  Classification: clustering
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [g ; ]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  identity_threshold:
    type: float?
    default: 0.90
    doc: IDENTITY_THRESHOLD parameter
  sort_algorithm:
    type: string?
    default: "[ sort|mergesort ]"
    doc: SORT_ALGORITHM parameter

outputs:
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
  cluster_output:
    type: File
    outputBinding:
      glob: "*.cluster"
    doc: cluster format output
  sorted_output:
    type: File
    outputBinding:
      glob: "*.sorted"
    doc: sorted format output
