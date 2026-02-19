cwlVersion: v1.2
class: CommandLineTool
id: predict_prokaryotic_gene_function
label: predict_prokaryotic_gene_function
doc: |
  none
  Classification: functional prediction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [UNKNOWN]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  annotate_on:
    type: string?
    default: "transcript"
    doc: ANNOTATE_ON parameter
  hmm_info:
    type: string?
    doc: HMM_INFO parameter
  ber_info:
    type: string?
    doc: BER_INFO parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
