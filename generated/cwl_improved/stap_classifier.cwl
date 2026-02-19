cwlVersion: v1.2
class: CommandLineTool
id: stap_classifier
label: stap_classifier
doc: |
  none
  Classification: phylogeny
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [stap_classifier]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  unclassified_neighbors:
    type: int?
    default: 5
    doc: UNCLASSIFIED_NEIGHBORS parameter
  second_tree_step_up:
    type: int?
    default: 1
    doc: SECOND_TREE_STEP_UP parameter
  domain:
    type: string?
    doc: DOMAIN parameter

outputs:
  results_output:
    type: File
    outputBinding:
      glob: "*.results"
    doc: results format output
