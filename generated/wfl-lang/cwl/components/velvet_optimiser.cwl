cwlVersion: v1.2
class: CommandLineTool
id: velvet_optimiser
label: velvet_optimiser
doc: |
  none
  Classification: assembly
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
  velvet_path:
    type: string?
    default: "$;VELVET_INSTALL_DIR$;"
    doc: VELVET_PATH parameter
  start_hash_length:
    type: int?
    default: 19
    doc: START_HASH_LENGTH parameter
  end_hash_length:
    type: int?
    default: 31
    doc: END_HASH_LENGTH parameter
  other_optimiser_opts:
    type: string?
    default: "-a yes"
    doc: OTHER_OPTIMISER_OPTS parameter

outputs:
  contig_output:
    type: File
    outputBinding:
      glob: "*.contig"
    doc: contig format output
