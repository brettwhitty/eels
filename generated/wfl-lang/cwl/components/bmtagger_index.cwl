cwlVersion: v1.2
class: CommandLineTool
id: bmtagger_index
label: bmtagger_index
doc: |
  none
  Classification: file / indexing
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
  max_ambiguities:
    type: string?
    doc: MAX_AMBIGUITIES parameter
  word_size:
    type: int?
    default: 18
    doc: WORD_SIZE parameter
  memory_required:
    type: int?
    default: 8704
    doc: MEMORY_REQUIRED parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
