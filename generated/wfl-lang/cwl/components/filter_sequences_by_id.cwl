cwlVersion: v1.2
class: CommandLineTool
id: filter_sequences_by_id
label: filter_sequences_by_id
doc: |
  none
  Classification: sequence / manipulation
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [filter_sequences_by_id]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  id_column_num:
    type: int?
    default: 1
    doc: ID_COLUMN_NUM parameter
  input_format:
    type: string?
    doc: INPUT_FORMAT parameter
  filter_mode:
    type: string?
    default: "exclude"
    doc: FILTER_MODE parameter

outputs:
  seq_output:
    type: File
    outputBinding:
      glob: "*.seq"
    doc: seq format output
