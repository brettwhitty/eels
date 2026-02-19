cwlVersion: v1.2
class: CommandLineTool
id: sam2lca
label: sam2lca
doc: |
  Find lowest common ancestor through a filtered BAM alignment file
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
    default: "/local/db/repository/ncbi/blast/20120414_001321/taxonomy/taxdump/"
    doc: NCBITAX parameter
  gi2tax:
    type: string?
    default: "/local/db/repository/ncbi/blast/20120414_001321/taxonomy/gi_taxid_nucl.dmp"
    doc: GI2TAX parameter
  host:
    type: string?
    default: "revan.igs.umaryland.edu:10001"
    doc: HOST parameter
  taxondb:
    type: string?
    default: "gi2taxon"
    doc: TAXONDB parameter
  taxoncoll:
    type: string?
    default: "gi2taxonnuc"
    doc: TAXONCOLL parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
