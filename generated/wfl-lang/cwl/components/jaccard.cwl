cwlVersion: v1.2
class: CommandLineTool
id: jaccard
label: jaccard
doc: |
  none
  Classification: clustering
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [clusterBsmlPairwiseAlignments]

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
  max_multi_alignment:
    type: int?
    default: 30
    doc: MAX_MULTI_ALIGNMENT parameter
  pidentity_cutoff:
    type: int?
    default: 80
    doc: PIDENTITY_CUTOFF parameter
  psimilarity_cutoff:
    type: string?
    doc: PSIMILARITY_CUTOFF parameter
  pcoverage_cutoff:
    type: int?
    default: 70
    doc: PCOVERAGE_CUTOFF parameter
  linkscore:
    type: string?
    default: ".6"
    doc: LINKSCORE parameter
  use_feature_ids_in_fasta:
    type: string?
    doc: USE_FEATURE_IDS_IN_FASTA parameter

outputs:
  fasta_output:
    type: File
    outputBinding:
      glob: "*.fasta"
    doc: fasta format output
