cwlVersion: v1.2
class: CommandLineTool
id: snap
label: snap
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [snap]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  hmm_file:
    type: string?
    doc: HMM_FILE parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter
  input_seq_class:
    type: string?
    default: "assembly"
    doc: INPUT_SEQ_CLASS parameter

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
