cwlVersion: v1.2
class: CommandLineTool
id: gsnap
label: gsnap
doc: |
  runs the slice-aware GSNAP aligner after setting up a GMAP database
  Classification: alignment
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
  reference:
    type: string?
    doc: REFERENCE parameter
  other_gmap_setup_options:
    type: string?
    doc: OTHER_GMAP_SETUP_OPTIONS parameter
  reads:
    type: string?
    doc: READS parameter
  max_mismatches:
    type: int?
    default: 3
    doc: MAX_MISMATCHES parameter
  indel_penalty:
    type: int?
    default: 1000
    doc: INDEL_PENALTY parameter
  indel_end_length:
    type: int?
    default: 3
    doc: INDEL_END_LENGTH parameter
  max_paired_length:
    type: int?
    default: 1000
    doc: MAX_PAIRED_LENGTH parameter
  expected_paired_length:
    type: int?
    default: 200
    doc: EXPECTED_PAIRED_LENGTH parameter
  threads:
    type: int?
    default: 1
    doc: THREADS parameter
  max_paths:
    type: int?
    default: 100
    doc: MAX_PATHS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
