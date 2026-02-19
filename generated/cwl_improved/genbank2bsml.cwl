cwlVersion: v1.2
class: CommandLineTool
id: genbank2bsml
label: genbank2bsml
doc: |
  none
  Classification: file / conversion
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [mkdir]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  organism_to_prefix_mapping:
    type: string?
    default: "/dev/null"
    doc: ORGANISM_TO_PREFIX_MAPPING parameter
  generate_new_seq_ids:
    type: int?
    default: 1
    doc: GENERATE_NEW_SEQ_IDS parameter
  skip_unknown_dbxref:
    type: string?
    doc: SKIP_UNKNOWN_DBXREF parameter
  skip_incomplete_feature_groups:
    type: int?
    default: 1
    doc: SKIP_INCOMPLETE_FEATURE_GROUPS parameter
  unique_feature_tags:
    type: string?
    default: "locus_tag,protein_id,systematic_id,gene"
    doc: UNIQUE_FEATURE_TAGS parameter
  translate_empty_cds:
    type: string?
    doc: TRANSLATE_EMPTY_CDS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
