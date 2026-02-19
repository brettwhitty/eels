cwlVersion: v1.2
class: CommandLineTool
id: stap_aligner
label: stap_aligner
doc: |
  none
  Classification: phylogeny
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [stap_aligner]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  domain:
    type: string?
    default: "P"
    doc: DOMAIN parameter

outputs:
  results_output:
    type: File
    outputBinding:
      glob: "*.results"
    doc: results format output
