cwlVersion: v1.2
class: CommandLineTool
id: filter_bogus_genes
label: filter_bogus_genes
doc: |
  none
  Classification: utility
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [filter_bogus_genes]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  base:
    type: string?
    doc: BASE parameter
  cutoff:
    type: float?
    default: 0.5
    doc: CUTOFF parameter

outputs:
  fsa_output:
    type: File
    outputBinding:
      glob: "*.fsa"
    doc: fsa format output
