cwlVersion: v1.2
class: CommandLineTool
id: tRNAscan-SE_compress
label: tRNAscan-SE_compress
doc: |
  none
  Classification: feature prediction / tRNAs
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [tRNAscan-SE_compress]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  search_type:
    type: string?
    default: "G"
    doc: SEARCH_TYPE parameter
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
