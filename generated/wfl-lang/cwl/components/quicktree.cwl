cwlVersion: v1.2
class: CommandLineTool
id: quicktree
label: quicktree
doc: |
  none
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [quicktree]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  input_type:
    type: string?
    default: "a"
    doc: INPUT_TYPE parameter
  quicktree_opts:
    type: string?
    doc: QUICKTREE_OPTS parameter

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
