cwlVersion: v1.2
class: CommandLineTool
id: psortb
label: psortb
doc: |
  Executes the PSortB script
  Classification: clustering
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [psortb]

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

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
