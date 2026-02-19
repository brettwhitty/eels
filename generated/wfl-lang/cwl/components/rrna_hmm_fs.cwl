cwlVersion: v1.2
class: CommandLineTool
id: rrna_hmm_fs
label: rrna_hmm_fs
doc: |
  none
  Classification: feature prediction / RNAs
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [rrna_hmm_fs]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  evalue:
    type: float?
    default: 0.01
    doc: EVALUE parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

outputs:
  rrna_hmm_output:
    type: File
    outputBinding:
      glob: "*.rrna_hmm"
    doc: rrna_hmm format output
