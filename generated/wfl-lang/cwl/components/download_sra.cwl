cwlVersion: v1.2
class: CommandLineTool
id: download_sra
label: download_sra
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
  ftp_path:
    type: string?
    default: "ftp-trace.ncbi.nih.gov"
    doc: FTP_PATH parameter
  run_id:
    type: string?
    doc: RUN_ID parameter
  fetch_metadata:
    type: int?
    default: 1
    doc: FETCH_METADATA parameter
  username:
    type: string?
    doc: USERNAME parameter
  password:
    type: string?
    doc: PASSWORD parameter
  num_retries:
    type: string?
    doc: NUM_RETRIES parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
