cwlVersion: v1.2
class: CommandLineTool
id: parse_evidence
label: parse_evidence
doc: |
  none
  Classification: file / conversion
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
  annotate_on:
    type: string?
    default: "transcript"
    doc: ANNOTATE_ON parameter
  bsml_feature_lookup_list:
    type: string?
    doc: BSML_FEATURE_LOOKUP_LIST parameter
  evidence_type:
    type: string?
    doc: EVIDENCE_TYPE parameter
  other_parser_options:
    type: string?
    doc: OTHER_PARSER_OPTIONS parameter

outputs:
  tab_output:
    type: File
    outputBinding:
      glob: "*.tab"
    doc: tab format output
