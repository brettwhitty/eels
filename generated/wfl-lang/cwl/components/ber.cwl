cwlVersion: v1.2
class: CommandLineTool
id: ber
label: ber
doc: |
  none
  Classification: alignment / pairwise
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [ber_blast_hit_selector]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  max_e_value:
    type: float?
    default: 1e-5
    doc: MAX_E_VALUE parameter
  max_p_value:
    type: float?
    default: 1e-5
    doc: MAX_P_VALUE parameter
  max_num_hits:
    type: int?
    default: 150
    doc: MAX_NUM_HITS parameter
  max_num_hits_per_region:
    type: string?
    doc: MAX_NUM_HITS_PER_REGION parameter
  min_num_experimental:
    type: string?
    doc: MIN_NUM_EXPERIMENTAL parameter
  bp_offset:
    type: int?
    default: 300
    doc: BP_OFFSET parameter
  additional_minidb_fasta:
    type: string?
    doc: ADDITIONAL_MINIDB_FASTA parameter
  additional_blast_hits_list:
    type: string?
    doc: ADDITIONAL_BLAST_HITS_LIST parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter
  project_abbreviation:
    type: string?
    default: "parse"
    doc: PROJECT_ABBREVIATION parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  btab_output:
    type: File
    outputBinding:
      glob: "*.btab"
    doc: btab format output
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
