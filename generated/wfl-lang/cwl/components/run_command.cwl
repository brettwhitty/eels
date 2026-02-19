cwlVersion: v1.2
class: CommandLineTool
id: run_command
label: run_command
doc: |
  none
  Classification: omnidexterous
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
  input_command:
    type: string?
    default: "touch $;ITER_FILE_PATH$;"
    doc: INPUT_COMMAND parameter
  input_args:
    type: string?
    doc: INPUT_ARGS parameter
  command_stdout:
    type: string?
    default: "$;TMP_DIR$;/runcommand.stdout"
    doc: COMMAND_STDOUT parameter
  command_stderr:
    type: string?
    default: "$;TMP_DIR$;/runcommand.stderr"
    doc: COMMAND_STDERR parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
