cwlVersion: v1.2
class: CommandLineTool
id: formatdb_snp
label: formatdb_snp
doc: |
  none
  Classification: SNP
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [formatdb_snp]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  protein:
    type: string?
    default: "F"
    doc: PROTEIN parameter
  database_name:
    type: string?
    doc: DATABASE_NAME parameter
  other_formatdb_args:
    type: string?
    doc: OTHER_FORMATDB_ARGS parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
