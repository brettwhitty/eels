cwlVersion: v1.2
class: CommandLineTool
id: glimmerHMM
label: glimmerHMM
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [glimmerHMM]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  training_directory:
    type: string?
    default: "/local/devel/ANNOTATION/GlimmerHMM/trained_dir"
    doc: TRAINING_DIRECTORY parameter

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
