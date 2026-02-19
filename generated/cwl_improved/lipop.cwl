cwlVersion: v1.2
class: CommandLineTool
id: lipop
label: lipop
doc: |
  none
  Classification: functional prediction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [lipop]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  cutoff:
    type: string?
    default: "-3"
    doc: CUTOFF parameter
  project_abbr:
    type: string?
    default: "$;PROJECT$;"
    doc: PROJECT_ABBR parameter

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
