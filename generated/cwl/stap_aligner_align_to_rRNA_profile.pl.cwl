cwlVersion: v1.2
class: CommandLineTool
id: stap_aligner_align_to_rRNA_profile.pl
label: align_to_rRNA_profile.pl from stap_aligner component
doc: Tool execution from Ergatis stap_aligner component (TIGR/JCVI/IGS)
baseCommand:
- align_to_rRNA_profile.pl
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
