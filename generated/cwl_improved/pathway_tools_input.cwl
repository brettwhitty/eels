cwlVersion: v1.2
class: CommandLineTool
id: pathway_tools_input
label: pathway_tools_input
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
    doc: DATABASE parameter
  db_host:
    type: string?
    doc: DB_HOST parameter
  username:
    type: string?
    doc: USERNAME parameter
  password:
    type: string?
    doc: PASSWORD parameter
  password_file:
    type: string?
    doc: PASSWORD_FILE parameter
  locus_db:
    type: string?
    doc: LOCUS_DB parameter
  organism_name:
    type: string?
    doc: ORGANISM_NAME parameter
  taxon_id:
    type: string?
    doc: TAXON_ID parameter

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
