cwlVersion: v1.2
class: CommandLineTool
id: parse_for_ncRNAs
label: parse_for_ncRNAs
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [parse_for_ncRNAs]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  bsml_lists:
    type: string?
    doc: BSML_LISTS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
