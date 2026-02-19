cwlVersion: v1.2
class: CommandLineTool
id: auto_gene_curation
label: auto_gene_curation
doc: |
  none
  Classification: functional prediction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [auto_gene_curation]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  ber_input:
    type: string?
    doc: BER_INPUT parameter
  hmm_input:
    type: string?
    doc: HMM_INPUT parameter
  hmm_info_db:
    type: string?
    doc: HMM_INFO_DB parameter
  names_dump:
    type: string?
    default: "$;REPOSITORY_ROOT$;/data_dbs/taxdump/names.dmp"
    doc: NAMES_DUMP parameter
  nodes_dump:
    type: string?
    default: "$;REPOSITORY_ROOT$;/data_dbs/taxdump/nodes.dmp"
    doc: NODES_DUMP parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
