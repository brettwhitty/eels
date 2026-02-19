cwlVersion: v1.2
class: CommandLineTool
id: pangenome_make_graphs
label: pangenome_make_graphs
doc: |
  none
  Classification: unclassified
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [pangenome_make_graphs]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  r_exec:
    type: string?
    doc: R_EXEC parameter
  use_eps:
    type: int?
    default: 1
    doc: USE_EPS parameter

outputs:
  ps_output:
    type: File
    outputBinding:
      glob: "*.ps"
    doc: ps format output
  eps_output:
    type: File
    outputBinding:
      glob: "*.eps"
    doc: eps format output
