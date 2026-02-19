cwlVersion: v1.2
class: CommandLineTool
id: aat_na
label: aat_na
doc: |
  none
  Classification: alignment / pairwise
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [aat_na]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  dds_opts:
    type: string?
    default: "-f 100 -i 30 -o 75 -p 70 -a 2000"
    doc: DDS_OPTS parameter
  database_path:
    type: string?
    doc: DATABASE_PATH parameter
  gap2_database_path:
    type: string?
    default: "$;DATABASE_PATH$;"
    doc: GAP2_DATABASE_PATH parameter
  ext_opts:
    type: string?
    doc: EXT_OPTS parameter
  filter_opts:
    type: string?
    default: "-c 10"
    doc: FILTER_OPTS parameter
  gap2_opts:
    type: string?
    doc: GAP2_OPTS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  btab_output:
    type: File
    outputBinding:
      glob: "*.btab"
    doc: btab format output
  gap2_output:
    type: File
    outputBinding:
      glob: "*.gap2"
    doc: gap2 format output
