cwlVersion: v1.2
class: CommandLineTool
id: wga_maf2tree
label: wga_maf2tree
doc: |
  Take a whole genome alignment maf file and make a tree (uses phylomark)
  Classification: phylogeny
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

outputs:
  output_file:
    type: File
    outputBinding:
      glob: "*.out"
