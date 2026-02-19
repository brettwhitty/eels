cwlVersion: v1.2
class: CommandLineTool
id: genbank2gtf
label: genbank2gtf
doc: |
  Convert Genbank file into GTF reference file
  Classification: RNA-Seq
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
  source:
    type: string?
    doc: SOURCE parameter
  other_args:
    type: string?
    default: "--v --f"
    doc: OTHER_ARGS parameter

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
