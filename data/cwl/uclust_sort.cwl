cwlVersion: v1.2
class: CommandLineTool
id: uclust_sort
label: sort from uclust component
doc: Tool execution from Ergatis uclust component (TIGR/JCVI/IGS)
baseCommand:
- cd $;TMP_DIR$;/$;ITERATOR_NAME$;/g$;GROUP_NUMBER$; ; $;UCLUST_EXEC$;
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
