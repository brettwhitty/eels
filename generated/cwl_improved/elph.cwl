cwlVersion: v1.2
class: CommandLineTool
id: elph
label: elph
doc: |
  none
  Classification: functional prediction
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
  motif_length:
    type: string?
    doc: MOTIF_LENGTH parameter
  iterator_num:
    type: int?
    default: 10
    doc: ITERATOR_NUM parameter
  max_loop:
    type: int?
    default: 500
    doc: MAX_LOOP parameter
  iter_signifigance:
    type: int?
    default: 1000
    doc: ITER_SIGNIFIGANCE parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

outputs:
  motif_output:
    type: File
    outputBinding:
      glob: "*.motif"
    doc: motif format output
