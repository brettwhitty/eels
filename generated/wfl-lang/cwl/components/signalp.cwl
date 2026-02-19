cwlVersion: v1.2
class: CommandLineTool
id: signalp
label: signalp
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
  organism_type:
    type: string?
    default: "euk"
    doc: ORGANISM_TYPE parameter
  prediction_method:
    type: string?
    default: "best"
    doc: PREDICTION_METHOD parameter
  truncated_length:
    type: int?
    default: 70
    doc: TRUNCATED_LENGTH parameter
  args:
    type: string?
    doc: ARGS parameter

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
  gif_output:
    type: File
    outputBinding:
      glob: "*.gif"
    doc: gif format output
  eps_output:
    type: File
    outputBinding:
      glob: "*.eps"
    doc: eps format output
  ps_output:
    type: File
    outputBinding:
      glob: "*.ps"
    doc: ps format output
  gnu_output:
    type: File
    outputBinding:
      glob: "*.gnu"
    doc: gnu format output
