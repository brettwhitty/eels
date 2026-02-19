cwlVersion: v1.2
class: CommandLineTool
id: fuzznuc
label: fuzznuc
doc: |
  none
  Classification: alignment / model
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [fuzznuc]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  complement_search:
    type: string?
    default: "N"
    doc: COMPLEMENT_SEARCH parameter
  pattern_name:
    type: string?
    doc: PATTERN_NAME parameter

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
  htab_output:
    type: File
    outputBinding:
      glob: "*.htab"
    doc: htab format output
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
