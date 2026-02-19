cwlVersion: v1.2
class: CommandLineTool
id: phat
label: phat
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [phat]

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
    doc: TRAINING_DIRECTORY parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

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
  gff_output:
    type: File
    outputBinding:
      glob: "*.gff"
    doc: gff format output
