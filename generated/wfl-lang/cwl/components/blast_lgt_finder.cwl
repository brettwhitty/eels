cwlVersion: v1.2
class: CommandLineTool
id: blast_lgt_finder
label: blast_lgt_finder
doc: |
  Take best blast hits and find LGT for the given donor/host lineages
  Classification: LGT
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [filter_lgt_best_hit]

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
  mapping_file:
    type: string?
    doc: MAPPING_FILE parameter
  host_lineage:
    type: string?
    doc: HOST_LINEAGE parameter
  donor_lineage:
    type: string?
    doc: DONOR_LINEAGE parameter
  filter_lineage:
    type: string?
    doc: FILTER_LINEAGE parameter
  filter_min_overlap:
    type: int?
    default: 50
    doc: FILTER_MIN_OVERLAP parameter
  min_length:
    type: string?
    doc: MIN_LENGTH parameter
  max_overlap:
    type: string?
    doc: MAX_OVERLAP parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
