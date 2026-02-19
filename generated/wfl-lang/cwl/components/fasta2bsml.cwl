cwlVersion: v1.2
class: CommandLineTool
id: fasta2bsml
label: fasta2bsml
doc: |
  Ergatis component: fasta2bsml
  Classification: file / conversion
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
  format:
    type: string?
    default: "single"
    doc: FORMAT parameter
  class:
    type: string?
    default: "assembly"
    doc: CLASS parameter
  genus:
    type: string?
    doc: GENUS parameter
  species:
    type: string?
    doc: SPECIES parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
