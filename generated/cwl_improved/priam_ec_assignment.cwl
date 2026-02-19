cwlVersion: v1.2
class: CommandLineTool
id: priam_ec_assignment
label: priam_ec_assignment
doc: |
  none
  Classification: functional prediction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [assign_ec_from_rps]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  e_value_cutoff:
    type: float?
    default: 1e-10
    doc: E_VALUE_CUTOFF parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
