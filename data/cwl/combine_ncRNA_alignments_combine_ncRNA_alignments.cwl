cwlVersion: v1.2
class: CommandLineTool
id: combine_ncRNA_alignments_combine_ncRNA_alignments
label: combine_ncRNA_alignments from combine_ncRNA_alignments component
doc: Tool execution from Ergatis combine_ncRNA_alignments component (TIGR/JCVI/IGS)
baseCommand:
- combine_ncRNA_alignments
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
