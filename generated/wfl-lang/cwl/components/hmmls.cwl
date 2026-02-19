cwlVersion: v1.2
class: CommandLineTool
id: hmmls
label: hmmls
doc: |
  none
  Classification: alignment / model
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [replace_fasta_headers.pl]

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
    default: "-c"
    doc: OTHER_OPTS parameter
  threshold_cutoff:
    type: string?
    doc: THRESHOLD_CUTOFF parameter
  search_window:
    type: int?
    default: 1000
    doc: SEARCH_WINDOW parameter
  model_name:
    type: string?
    doc: MODEL_NAME parameter
  model_mol_type:
    type: string?
    default: "aa"
    doc: MODEL_MOL_TYPE parameter
  model_mol_class:
    type: string?
    default: "polypeptide"
    doc: MODEL_MOL_CLASS parameter
  query_mol_type:
    type: string?
    default: "aa"
    doc: QUERY_MOL_TYPE parameter
  query_mol_class:
    type: string?
    default: "polypeptide"
    doc: QUERY_MOL_CLASS parameter
  leave_fasta_headers:
    type: string?
    doc: LEAVE_FASTA_HEADERS parameter

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
  htab_output:
    type: File
    outputBinding:
      glob: "*.htab"
    doc: htab format output
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
