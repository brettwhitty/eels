cwlVersion: v1.2
class: CommandLineTool
id: profile_gff3
label: profile_gff3
doc: |
  none
  Classification: profile
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [gff3Profiler]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file

outputs:
  prof_output:
    type: File
    outputBinding:
      glob: "*.prof"
    doc: prof format output
