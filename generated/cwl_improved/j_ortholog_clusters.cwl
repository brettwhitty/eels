cwlVersion: v1.2
class: CommandLineTool
id: j_ortholog_clusters
label: j_ortholog_clusters
doc: |
  none
  Classification: clustering
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
  pvalcut:
    type: float?
    default: 1e-5
    doc: PVALCUT parameter
  pcoverage_cutoff:
    type: int?
    default: 70
    doc: PCOVERAGE_CUTOFF parameter
  pidentity_cutoff:
    type: string?
    doc: PIDENTITY_CUTOFF parameter
  psimilarity_cutoff:
    type: string?
    doc: PSIMILARITY_CUTOFF parameter
  max_multi_alignment:
    type: int?
    default: 100
    doc: MAX_MULTI_ALIGNMENT parameter
  jaccard_cutoff:
    type: float?
    default: 0.0
    doc: JACCARD_CUTOFF parameter
  use_feature_ids_in_fasta:
    type: string?
    doc: USE_FEATURE_IDS_IN_FASTA parameter

outputs:
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
