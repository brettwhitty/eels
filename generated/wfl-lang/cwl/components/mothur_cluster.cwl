cwlVersion: v1.2
class: CommandLineTool
id: mothur_cluster
label: mothur_cluster
doc: |
  none
  Classification: clustering
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mothur]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  dist_format:
    type: string?
    default: "[ phylip|column ]"
    doc: DIST_FORMAT parameter
  cutoff:
    type: string?
    doc: CUTOFF parameter
  config_options:
    type: string?
    doc: CONFIG_OPTIONS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
