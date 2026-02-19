cwlVersion: v1.2
class: CommandLineTool
id: pepstats
label: pepstats
doc: |
  none
  Classification: sequence / properties
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [pepstats.sh]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file

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
