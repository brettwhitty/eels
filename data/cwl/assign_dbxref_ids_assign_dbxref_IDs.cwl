cwlVersion: v1.2
class: CommandLineTool
id: assign_dbxref_ids_assign dbxref IDs
label: assign dbxref IDs from assign_dbxref_ids component
doc: Tool execution from Ergatis assign_dbxref_ids component (TIGR/JCVI/IGS)
baseCommand:
- assign dbxref IDs
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
