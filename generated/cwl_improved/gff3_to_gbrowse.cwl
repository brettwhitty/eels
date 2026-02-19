cwlVersion: v1.2
class: CommandLineTool
id: gff3_to_gbrowse
label: gff3_to_gbrowse
doc: |
  none
  Classification: file / conversion
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [gff3_to_gbrowse.py]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  gbrowse_conf_directory:
    type: string?
    doc: GBROWSE_CONF_DIRECTORY parameter
  gbrowse_master_conf:
    type: string?
    doc: GBROWSE_MASTER_CONF parameter
  gbrowse_conf_template:
    type: string?
    doc: GBROWSE_CONF_TEMPLATE parameter
  organism:
    type: string?
    doc: ORGANISM parameter
  hostname:
    type: string?
    doc: HOSTNAME parameter
  db_name:
    type: string?
    doc: DB_NAME parameter
  username:
    type: string?
    doc: USERNAME parameter
  password:
    type: string?
    doc: PASSWORD parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
