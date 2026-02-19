cwlVersion: v1.2
class: CommandLineTool
id: pseudomolecule2glimmer3
label: pseudomolecule2glimmer3
doc: |
  none
  Classification: utility
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
  contig_name:
    type: string?
    doc: CONTIG_NAME parameter
  project_abbreviation:
    type: string?
    default: "$;PROJECT$;"
    doc: PROJECT_ABBREVIATION parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
