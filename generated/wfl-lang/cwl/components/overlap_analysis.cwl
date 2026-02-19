cwlVersion: v1.2
class: CommandLineTool
id: overlap_analysis
label: overlap_analysis
doc: |
  none
  Classification: structural prediction
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
  cutoff:
    type: int?
    default: 60
    doc: CUTOFF parameter
  sequence_class:
    type: string?
    default: "assembly"
    doc: SEQUENCE_CLASS parameter
  rna_bsml:
    type: string?
    doc: RNA_BSML parameter
  evidence_bsml:
    type: string?
    doc: EVIDENCE_BSML parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
