cwlVersion: v1.2
class: CommandLineTool
id: genbank2fasta
label: genbank2fasta
doc: |
  none
  Classification: file / conversion
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

outputs:
  fsa_output:
    type: File
    outputBinding:
      glob: "*.fsa"
    doc: fsa format output
