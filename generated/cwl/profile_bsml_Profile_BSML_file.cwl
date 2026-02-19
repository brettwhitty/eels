cwlVersion: v1.2
class: CommandLineTool
id: profile_bsml_Profile BSML file
label: Profile BSML file from profile_bsml component
doc: Tool execution from Ergatis profile_bsml component (TIGR/JCVI/IGS)
baseCommand:
- Profile BSML file
inputs:
  input_file:
    type: File
    inputBinding:
      position: 1
outputs:
  output_file:
    type: File
    outputBinding:
      glob: '*.out'
