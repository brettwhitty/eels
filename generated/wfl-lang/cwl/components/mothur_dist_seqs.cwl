cwlVersion: v1.2
class: CommandLineTool
id: mothur_dist_seqs
label: mothur_dist_seqs
doc: |
  none
  Classification: phylogeny
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
  calc:
    type: string?
    default: "[ onegap|nogaps|eachgap ]"
    doc: CALC parameter
  countends:
    type: string?
    default: "T"
    doc: COUNTENDS parameter
  cutoff:
    type: string?
    doc: CUTOFF parameter
  phylip:
    type: string?
    default: "F"
    doc: PHYLIP parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
