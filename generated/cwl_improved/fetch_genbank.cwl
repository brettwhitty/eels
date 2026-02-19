cwlVersion: v1.2
class: CommandLineTool
id: fetch_genbank
label: fetch_genbank
doc: |
  none
  Classification: utility
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
  database:
    type: string?
    default: "nucleotide"
    doc: DATABASE parameter
  query:
    type: string?
    doc: QUERY parameter
  format:
    type: string?
    default: "fasta"
    doc: FORMAT parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
