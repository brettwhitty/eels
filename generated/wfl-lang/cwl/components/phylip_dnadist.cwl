cwlVersion: v1.2
class: CommandLineTool
id: phylip_dnadist
label: phylip_dnadist
doc: |
  none
  Classification: phylogeny
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [dnadist_worker_wrapper]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  control_file:
    type: string?
    doc: CONTROL_FILE parameter
  group_size:
    type: int?
    default: 1000000
    doc: GROUP_SIZE parameter

outputs:
  results_output:
    type: File
    outputBinding:
      glob: "*.results"
    doc: results format output
