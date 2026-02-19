cwlVersion: v1.2
class: CommandLineTool
id: aat_aa_masked
label: aat_aa_masked
doc: |
  none
  Classification: alignment / pairwise
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [aat_aa_masked]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  dps_opts:
    type: string?
    default: "-f 100 -i 30 -a 2000"
    doc: DPS_OPTS parameter
  matrix:
    type: string?
    default: "/usr/local/common/BS"
    doc: MATRIX parameter
  ext_opts:
    type: string?
    doc: EXT_OPTS parameter
  filter_opts:
    type: string?
    default: "-c 20"
    doc: FILTER_OPTS parameter
  nap_opts:
    type: string?
    doc: NAP_OPTS parameter
  cutoff_identity:
    type: string?
    doc: CUTOFF_IDENTITY parameter
  cutoff_similarity:
    type: string?
    doc: CUTOFF_SIMILARITY parameter

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
  nap_output:
    type: File
    outputBinding:
      glob: "*.nap"
    doc: nap format output
