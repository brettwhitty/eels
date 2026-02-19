cwlVersion: v1.2
class: CommandLineTool
id: pipeline_summary
label: pipeline_summary
doc: |
  Ergatis component: pipeline_summary
  Classification: functional prediction
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
  other_bsml_lists:
    type: string?
    doc: OTHER_BSML_LISTS parameter
  cogs_bsml_list:
    type: string?
    doc: COGS_BSML_LIST parameter
  cog_lookup:
    type: string?
    default: "/usr/local/db/common/ncbi_cogs/whog.1"
    doc: COG_LOOKUP parameter
  nog_members:
    type: string?
    doc: NOG_MEMBERS parameter
  nog_description:
    type: string?
    doc: NOG_DESCRIPTION parameter
  nog_bsml_list:
    type: string?
    doc: NOG_BSML_LIST parameter
  locus_prefix:
    type: string?
    doc: LOCUS_PREFIX parameter
  organism:
    type: string?
    doc: ORGANISM parameter
  translation_table:
    type: int?
    default: 11
    doc: TRANSLATION_TABLE parameter
  cds_fasta:
    type: string?
    doc: CDS_FASTA parameter
  polypeptide_fasta:
    type: string?
    doc: POLYPEPTIDE_FASTA parameter
  sourcename:
    type: string?
    doc: SOURCENAME parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
