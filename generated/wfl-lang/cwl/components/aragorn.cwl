cwlVersion: v1.2
class: CommandLineTool
id: aragorn
label: aragorn
doc: |
  none
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [aragorn]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter
  project_name:
    type: string?
    default: "parse"
    doc: PROJECT_NAME parameter

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
