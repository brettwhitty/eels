cwlVersion: v1.2
class: CommandLineTool
id: combine_ncRNA_alignments
label: combine_ncRNA_alignments
doc: |
  none
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [combine_ncRNA_alignemnts]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  project_name:
    type: string?
    default: "$;PROJECT$;"
    doc: PROJECT_NAME parameter
  other_bsml_lists:
    type: string?
    doc: OTHER_BSML_LISTS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  btab_output:
    type: File
    outputBinding:
      glob: "*.btab"
    doc: btab format output
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
