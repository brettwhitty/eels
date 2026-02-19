cwlVersion: v1.2
class: CommandLineTool
id: fastaToBsmlWorkingGeneModels
label: fastaToBsmlWorkingGeneModels
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
  database:
    type: string?
    default: "$;PROJECT$;"
    doc: DATABASE parameter
  input_fasta_list_file:
    type: string?
    doc: INPUT_FASTA_LIST_FILE parameter
  input_bsml_list_file:
    type: string?
    doc: INPUT_BSML_LIST_FILE parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
