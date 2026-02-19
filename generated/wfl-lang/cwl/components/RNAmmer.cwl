cwlVersion: v1.2
class: CommandLineTool
id: RNAmmer
label: RNAmmer
doc: |
  Ergatis component: RNAmmer
  Classification: feature prediction / RNAs
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [RNAmmer]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  kingdom:
    type: string?
    default: "bac"
    doc: KINGDOM parameter
  molecules:
    type: string?
    default: "lsu,tsu,ssu"
    doc: MOLECULES parameter
  project_abbreviation:
    type: string?
    default: "$;PROJECT$;"
    doc: PROJECT_ABBREVIATION parameter
  args:
    type: string?
    doc: ARGS parameter

outputs:
  bsml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: bsml format output
  xml_output:
    type: File
    outputBinding:
      glob: "*.xml"
    doc: xml format output
  gff_output:
    type: File
    outputBinding:
      glob: "*.gff"
    doc: gff format output
  hmmreport_output:
    type: File
    outputBinding:
      glob: "*.hmmreport"
    doc: hmmreport format output
