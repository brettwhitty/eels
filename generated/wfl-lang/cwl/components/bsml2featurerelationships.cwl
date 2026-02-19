cwlVersion: v1.2
class: CommandLineTool
id: bsml2featurerelationships
label: bsml2featurerelationships
doc: |
  none
  Classification: unclassified
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [UNKNOWN]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  add_assembly:
    type: int?
    default: 1
    doc: ADD_ASSEMBLY parameter
  add_feature_coordinates:
    type: string?
    default: "transcript"
    doc: ADD_FEATURE_COORDINATES parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
