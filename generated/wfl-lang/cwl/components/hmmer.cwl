cwlVersion: v1.2
class: CommandLineTool
id: hmmer
label: hmmer
doc: |
  none
  Classification: alignment / model
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [hmmer]

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
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
