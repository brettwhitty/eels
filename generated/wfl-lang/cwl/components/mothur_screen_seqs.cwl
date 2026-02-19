cwlVersion: v1.2
class: CommandLineTool
id: mothur_screen_seqs
label: mothur_screen_seqs
doc: |
  none
  Classification: utility
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
  config_options:
    type: string?
    doc: CONFIG_OPTIONS parameter

outputs:
  good_align_output:
    type: File
    outputBinding:
      glob: "*.good_align"
    doc: good_align format output
  bad_align_output:
    type: File
    outputBinding:
      glob: "*.bad_align"
    doc: bad_align format output
  good_groups_output:
    type: File
    outputBinding:
      glob: "*.good_groups"
    doc: good_groups format output
  bad_groups_output:
    type: File
    outputBinding:
      glob: "*.bad_groups"
    doc: bad_groups format output
  good_names_output:
    type: File
    outputBinding:
      glob: "*.good_names"
    doc: good_names format output
  bad_names_output:
    type: File
    outputBinding:
      glob: "*.bad_names"
    doc: bad_names format output
