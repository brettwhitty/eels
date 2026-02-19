cwlVersion: v1.2
class: CommandLineTool
id: create_pseudomolecules
label: create_pseudomolecules
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
  strain_name:
    type: string?
    doc: STRAIN_NAME parameter
  database:
    type: string?
    default: "nucleotide"
    doc: DATABASE parameter
  format:
    type: string?
    default: "fasta"
    doc: FORMAT parameter
  nucmer_config:
    type: string?
    default: "-c 100 -maxmatch"
    doc: NUCMER_CONFIG parameter
  linker_sequence:
    type: string?
    doc: LINKER_SEQUENCE parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
