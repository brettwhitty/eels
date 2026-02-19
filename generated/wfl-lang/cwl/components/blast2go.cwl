cwlVersion: v1.2
class: CommandLineTool
id: blast2go
label: blast2go
doc: |
  none
  Classification: functional prediction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [java]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  blast2go_install:
    type: string?
    doc: BLAST2GO_INSTALL parameter
  config_file:
    type: string?
    default: "$;BLAST2GO_INSTALL$;/b2gPipe.properties"
    doc: CONFIG_FILE parameter

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
