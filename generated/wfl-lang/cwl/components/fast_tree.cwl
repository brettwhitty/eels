cwlVersion: v1.2
class: CommandLineTool
id: fast_tree
label: fast_tree
doc: |
  none
  Classification: phylogeny
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [fast_tree]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  config_options:
    type: string?
    doc: CONFIG_OPTIONS parameter

outputs:
  tree_output:
    type: File
    outputBinding:
      glob: "*.tree"
    doc: tree format output
