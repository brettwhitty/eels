cwlVersion: v1.2
class: CommandLineTool
id: mummer
label: mummer
doc: |
  none
  Classification: alignment
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mummer]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  mummer_options:
    type: string?
    default: "-L -maxmatch"
    doc: MUMMER_OPTIONS parameter

outputs:
  tab_output:
    type: File
    outputBinding:
      glob: "*.tab"
    doc: tab format output
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
