cwlVersion: v1.2
class: CommandLineTool
id: phage_finder
label: phage_finder
doc: |
  none
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [run_phage_finder]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  info_file:
    type: string?
    doc: INFO_FILE parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter
  btab_list:
    type: string?
    doc: BTAB_LIST parameter
  aragorn_list:
    type: string?
    doc: ARAGORN_LIST parameter
  trna_scan_list:
    type: string?
    doc: TRNA_SCAN_LIST parameter
  polypeptide_multi_fsa:
    type: string?
    doc: POLYPEPTIDE_MULTI_FSA parameter
  phage_finder_dir:
    type: string?
    default: "/usr/local/devel/ANNOTATION/phage_finder"
    doc: PHAGE_FINDER_DIR parameter

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
