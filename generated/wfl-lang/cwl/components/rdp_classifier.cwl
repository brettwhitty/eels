cwlVersion: v1.2
class: CommandLineTool
id: rdp_classifier
label: rdp_classifier
doc: |
  none
  Classification: phylogeny
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [rdp_classifier]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  property_file:
    type: string?
    doc: PROPERTY_FILE parameter
  rdp_dir:
    type: string?
    default: "/usr/local/bioinf/rdp_classifier"
    doc: RDP_DIR parameter
  java_mx:
    type: string?
    default: "400m"
    doc: JAVA_MX parameter

outputs:
  results_output:
    type: File
    outputBinding:
      glob: "*.results"
    doc: results format output
