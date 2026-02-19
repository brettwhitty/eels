cwlVersion: v1.2
class: CommandLineTool
id: augustus
label: augustus
doc: |
  none
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [augustus]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  cds:
    type: string?
    default: "on"
    doc: CDS parameter
  species:
    type: string?
    doc: SPECIES parameter
  strand:
    type: string?
    default: "both"
    doc: STRAND parameter
  genemodel:
    type: string?
    default: "partial"
    doc: GENEMODEL parameter
  maxtracks:
    type: string?
    doc: MAXTRACKS parameter
  extrinsic_config_file:
    type: string?
    default: "$;AUGUSTUS_CONFIG_PATH$;/extrinsic/extrinsic.cfg"
    doc: EXTRINSIC_CONFIG_FILE parameter
  augustus_config_path:
    type: string?
    default: "$;AUGUSTUS_DIR$;/config"
    doc: AUGUSTUS_CONFIG_PATH parameter
  augustus_binary_path:
    type: string?
    default: "$;AUGUSTUS_DIR$;/bin/augustus"
    doc: AUGUSTUS_BINARY_PATH parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

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
