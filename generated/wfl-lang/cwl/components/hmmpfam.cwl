cwlVersion: v1.2
class: CommandLineTool
id: hmmpfam
label: hmmpfam
doc: |
  none
  Classification: alignment / model
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [hmmpfam]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  cutoffs:
    type: string?
    default: "[--cut_nc|--cut_tc|--cut_ga| ]"
    doc: CUTOFFS parameter
  other_opts:
    type: string?
    default: "--acc"
    doc: OTHER_OPTS parameter
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

outputs:
  raw_output:
    type: File
    outputBinding:
      glob: "*.txt"
    doc: raw format output
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  htab_output:
    type: File
    outputBinding:
      glob: "*.htab"
    doc: htab format output
