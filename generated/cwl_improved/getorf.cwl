cwlVersion: v1.2
class: CommandLineTool
id: getorf
label: getorf
doc: |
  Find open reading frames (ORFs) in eukaryotic assemblies
  Classification: feature prediction / genes
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [getorf]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  min_orf_length:
    type: int?
    default: 300
    doc: MIN_ORF_LENGTH parameter
  table:
    type: string?
    doc: TABLE parameter
  other_opts:
    type: string?
    doc: OTHER_OPTS parameter

outputs:
  fsa_output:
    type: File
    outputBinding:
      glob: "*.fsa"
    doc: fsa format output
