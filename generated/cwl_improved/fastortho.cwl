cwlVersion: v1.2
class: CommandLineTool
id: fastortho
label: fastortho
doc: |
  Wrapper component for the FastOrtho tool
  Classification: clustering
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
  max_e_value:
    type: float?
    default: 1e-5
    doc: MAX_E_VALUE parameter
  min_percent_id:
    type: float?
    default: 0.0
    doc: MIN_PERCENT_ID parameter
  min_percent_match:
    type: float?
    default: 0.0
    doc: MIN_PERCENT_MATCH parameter
  inflation:
    type: float?
    default: 1.5
    doc: INFLATION parameter
  num_cpus:
    type: int?
    default: 1
    doc: NUM_CPUS parameter
  mixed_genomes:
    type: int?
    default: 1
    doc: MIXED_GENOMES parameter
  other_args:
    type: string?
    default: "''"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
