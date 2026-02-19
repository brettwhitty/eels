cwlVersion: v1.2
class: CommandLineTool
id: stap_classifier_rRNA_pipeline_for_one.pl
label: rRNA_pipeline_for_one.pl from stap_classifier component
doc: Tool execution from Ergatis stap_classifier component (TIGR/JCVI/IGS)
baseCommand:
- rRNA_pipeline_for_one.pl
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
