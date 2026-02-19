cwlVersion: v1.2
class: CommandLineTool
id: update_euk_model_sequences_deriveCDSSequences
label: deriveCDSSequences from update_euk_model_sequences component
doc: Tool execution from Ergatis update_euk_model_sequences component (TIGR/JCVI/IGS)
baseCommand:
- deriveCDSSequences
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
