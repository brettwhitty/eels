cwlVersion: v1.2
class: CommandLineTool
id: nucmer
label: nucmer
doc: |
  none
  Classification: alignment
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mkdir]

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
    default: "-maxmatch -c 100"
    doc: CONFIG_OPTIONS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
