cwlVersion: v1.2
class: CommandLineTool
id: pangenome_blast_parse
label: pangenome_blast_parse
doc: |
  none
  Classification: unclassified
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [pangenome_blast_parse]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  coverage_cutoff:
    type: int?
    default: 50
    doc: COVERAGE_CUTOFF parameter
  similarity_cutoff:
    type: int?
    default: 50
    doc: SIMILARITY_CUTOFF parameter
  db_list:
    type: string?
    doc: DB_LIST parameter
  organism_to_db_mapping:
    type: string?
    doc: ORGANISM_TO_DB_MAPPING parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
