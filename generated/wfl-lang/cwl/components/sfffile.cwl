cwlVersion: v1.2
class: CommandLineTool
id: sfffile
label: sfffile
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [sfffile]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  raw_sff:
    type: string?
    doc: RAW_SFF parameter
  config_params:
    type: string?
    doc: CONFIG_PARAMS parameter

outputs:
  sff_output:
    type: File
    outputBinding:
      glob: "*.sff"
    doc: sff format output
