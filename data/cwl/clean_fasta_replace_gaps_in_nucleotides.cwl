cwlVersion: v1.2
class: CommandLineTool
id: clean_fasta_replace_gaps_in_nucleotides
label: replace_gaps_in_nucleotides from clean_fasta component
doc: Tool execution from Ergatis clean_fasta component (TIGR/JCVI/IGS)
baseCommand:
- replace_gaps_in_nucleotides
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
