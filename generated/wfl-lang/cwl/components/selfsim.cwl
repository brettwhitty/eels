cwlVersion: v1.2
class: CommandLineTool
id: selfsim
label: selfsim
doc: |
  Perform chi-squared analysis to find lateral gene transfer in eukaryotic assemblies
  Classification: LGT
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [selfsim]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  window_size:
    type: int?
    default: 5000
    doc: WINDOW_SIZE parameter
  shift:
    type: int?
    default: 1000
    doc: SHIFT parameter

outputs:
  txt_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: txt format output
