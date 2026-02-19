cwlVersion: v1.2
class: CommandLineTool
id: load_ber_for_manatee
label: load_ber_for_manatee
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
  db_username:
    type: string?
    doc: DB_USERNAME parameter
  db_password:
    type: string?
    doc: DB_PASSWORD parameter
  db_host:
    type: string?
    doc: DB_HOST parameter
  db_name:
    type: string?
    doc: DB_NAME parameter
  ber_output_directory:
    type: string?
    doc: BER_OUTPUT_DIRECTORY parameter
  destination_directory:
    type: string?
    doc: DESTINATION_DIRECTORY parameter
  local_directory:
    type: string?
    doc: LOCAL_DIRECTORY parameter
  ber_file_destination_server:
    type: string?
    doc: BER_FILE_DESTINATION_SERVER parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  btab_output:
    type: File
    outputBinding:
      glob: "*.btab"
    doc: btab format output
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
