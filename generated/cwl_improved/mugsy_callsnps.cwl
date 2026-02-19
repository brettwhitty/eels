cwlVersion: v1.2
class: CommandLineTool
id: mugsy_callsnps
label: mugsy_callsnps
doc: |
  Take a whole genome alignment maf file and call SNPs
  Classification: SNP
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
