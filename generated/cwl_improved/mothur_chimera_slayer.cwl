cwlVersion: v1.2
class: CommandLineTool
id: mothur_chimera_slayer
label: mothur_chimera_slayer
doc: |
  none
  Classification: alignment/classification/quality filtering
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
  minsim:
    type: int?
    default: 90
    doc: MINSIM parameter
  mincov:
    type: int?
    default: 70
    doc: MINCOV parameter
  bootiters:
    type: int?
    default: 100
    doc: BOOTITERS parameter
  minbootsupport:
    type: int?
    default: 90
    doc: MINBOOTSUPPORT parameter
  divergence:
    type: float?
    default: 1.007
    doc: DIVERGENCE parameter
  split:
    type: string?
    default: "T"
    doc: SPLIT parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
