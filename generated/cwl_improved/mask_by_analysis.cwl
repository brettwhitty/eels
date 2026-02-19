cwlVersion: v1.2
class: CommandLineTool
id: mask_by_analysis
label: mask_by_analysis
doc: |
  none
  Classification: sequence / manipulation
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mask_by_analysis]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  mask_character:
    type: string?
    default: "X"
    doc: MASK_CHARACTER parameter
  analysis_types:
    type: string?
    doc: ANALYSIS_TYPES parameter
  feature_classes:
    type: string?
    doc: FEATURE_CLASSES parameter
  softmask:
    type: string?
    doc: SOFTMASK parameter
  random:
    type: string?
    doc: RANDOM parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  fsa_output:
    type: File
    outputBinding:
      glob: "*.fsa"
    doc: fsa format output
