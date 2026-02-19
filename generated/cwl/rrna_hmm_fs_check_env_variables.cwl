cwlVersion: v1.2
class: CommandLineTool
id: rrna_hmm_fs_check env variables
label: check env variables from rrna_hmm_fs component
doc: Tool execution from Ergatis rrna_hmm_fs component (TIGR/JCVI/IGS)
baseCommand:
- env
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
