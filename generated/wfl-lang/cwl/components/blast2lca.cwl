cwlVersion: v1.2
class: CommandLineTool
id: blast2lca
label: blast2lca
doc: |
  Find lowest common ancestor through best blast hits
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
  evalue_cutoff:
    type: int?
    default: 1
    doc: EVALUE_CUTOFF parameter
  best_blast_hit:
    type: int?
    default: 1
    doc: BEST_BLAST_HIT parameter

outputs:
  output_list_output:
    type: File
    outputBinding:
      glob: "*.output_list"
    doc: output_list format output
