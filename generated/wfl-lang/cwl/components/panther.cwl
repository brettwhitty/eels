cwlVersion: v1.2
class: CommandLineTool
id: panther
label: panther
doc: |
  none
  Classification: alignment / model
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [panther]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  display_type:
    type: string?
    default: "B"
    doc: DISPLAY_TYPE parameter
  hmm_evalue_cutoff:
    type: float?
    default: 1e-3
    doc: HMM_EVALUE_CUTOFF parameter

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
