cwlVersion: v1.2
class: CommandLineTool
id: genewise
label: genewise
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [prepare_for_genewise_best_loc]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  other_opts:
    type: string?
    default: "-sum -pretty"
    doc: OTHER_OPTS parameter
  work_dir:
    type: string?
    default: "$;OUTPUT_DIRECTORY$;/work_dir"
    doc: WORK_DIR parameter
  padding_length:
    type: int?
    default: 500
    doc: PADDING_LENGTH parameter
  min_chain_score:
    type: int?
    default: 50
    doc: MIN_CHAIN_SCORE parameter
  num_tiers:
    type: int?
    default: 3
    doc: NUM_TIERS parameter
  min_percent_align_chain:
    type: int?
    default: 70
    doc: MIN_PERCENT_ALIGN_CHAIN parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
