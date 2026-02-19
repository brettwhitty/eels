cwlVersion: v1.2
class: CommandLineTool
id: btab2taxon
label: btab2taxon
doc: |
  none
  Classification: LGT
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
  ncbitax:
    type: string?
    default: "/local/db/repository/ncbi/blast/20110831_122720/taxonomy/taxdump/"
    doc: NCBITAX parameter
  gi2tax:
    type: string?
    default: "/local/db/repository/ncbi/blast/20110831_122720/taxonomy/gi_taxid_nucl.dmp"
    doc: GI2TAX parameter
  host:
    type: string?
    default: "tettelin-lx.igs.umaryland.edu"
    doc: HOST parameter
  taxondb:
    type: string?
    default: "gi2taxon"
    doc: TAXONDB parameter
  taxoncoll:
    type: string?
    default: "gi2taxonnuc_20110831_122720"
    doc: TAXONCOLL parameter
  overwrite:
    type: int?
    default: 1
    doc: OVERWRITE parameter
  idx_directory:
    type: string?
    default: "$;TMP_DIR$;"
    doc: IDX_DIRECTORY parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
