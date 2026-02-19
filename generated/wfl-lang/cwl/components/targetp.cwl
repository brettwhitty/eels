cwlVersion: v1.2
class: CommandLineTool
id: targetp
label: targetp
doc: |
  none
  Classification: functional prediction
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [targetp]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  organism_type:
    type: string?
    default: "P"
    doc: ORGANISM_TYPE parameter
  chloroplast_prediction_cutoff:
    type: float?
    default: 0.00
    doc: CHLOROPLAST_PREDICTION_CUTOFF parameter
  secretory_pathway_prediction_cutoff:
    type: float?
    default: 0.00
    doc: SECRETORY_PATHWAY_PREDICTION_CUTOFF parameter
  mitochondrial_prediction_cutoff:
    type: float?
    default: 0.00
    doc: MITOCHONDRIAL_PREDICTION_CUTOFF parameter
  other_location_prediction_cutoff:
    type: float?
    default: 0.00
    doc: OTHER_LOCATION_PREDICTION_CUTOFF parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

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
