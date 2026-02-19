cwlVersion: v1.2
class: CommandLineTool
id: validate_asn
label: validate_asn
doc: |
  none
  Classification: validation
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mkdir]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file

outputs:
  val_output:
    type: File
    outputBinding:
      glob: "*.val"
    doc: val format output
  discrpt_output:
    type: File
    outputBinding:
      glob: "*.discrpt"
    doc: discrpt format output
