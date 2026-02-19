cwlVersion: v1.2
class: CommandLineTool
id: rrna_hmm_fs_rRNA_hmm_fs
label: rRNA_hmm_fs from rrna_hmm_fs component
doc: Tool execution from Ergatis rrna_hmm_fs component (TIGR/JCVI/IGS)
baseCommand:
- rRNA_hmm_fs
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
