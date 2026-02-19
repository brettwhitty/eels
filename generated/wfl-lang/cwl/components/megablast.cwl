cwlVersion: v1.2
class: CommandLineTool
id: megablast
label: megablast
doc: |
  none
  Classification: alignment
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [megablast]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  wordsize:
    type: int?
    default: 16
    doc: WORDSIZE parameter

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
