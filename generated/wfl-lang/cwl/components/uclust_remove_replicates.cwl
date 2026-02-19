cwlVersion: v1.2
class: CommandLineTool
id: uclust_remove_replicates
label: uclust_remove_replicates
doc: |
  Ergatis component: uclust_remove_replicates
  Classification: clustering
  Source: Ergatis component (TIGR/JCVI/IGS)

baseCommand: [uclust_replicate_removal]

requirements:
  InlineJavascriptRequirement: {}

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
    doc: Input file
  length_difference:
    type: int?
    default: 10
    doc: LENGTH_DIFFERENCE parameter
  prefix_length:
    type: int?
    default: 8
    doc: PREFIX_LENGTH parameter
  stagedata:
    type: string?
    default: "$;REPOSITORY_ROOT$;/output_repository/uclust/$;PIPELINEID$;_default/uclust.sorted.list"
    doc: STAGEDATA parameter

outputs:
  cluster_output:
    type: File
    outputBinding:
      glob: "*.cluster"
    doc: cluster format output
  replicate_output:
    type: File
    outputBinding:
      glob: "*.replicate"
    doc: replicate format output
