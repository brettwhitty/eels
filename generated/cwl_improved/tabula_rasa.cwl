cwlVersion: v1.2
class: CommandLineTool
id: tabula_rasa
label: tabula_rasa
doc: |
  none
  Classification: omnidexterous
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [tabula_rasa]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  input_command:
    type: string?
    default: "touch $;ITER_FILE_PATH$;"
    doc: INPUT_COMMAND parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
