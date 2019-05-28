cwlVersion: v1.0
class: CommandLineTool
baseCommand: vsearch
inputs:
  file:
    type: File
    inputBinding:
      position: 1
      prefix: --cluster_size
  vsearch_out1:
    type: string
    inputBinding:
      position: 2
      prefix: --centroid
  vsearch_out2:
    type: string
    inputBinding:
      position: 3
      prefix: --clusters
  vsearch_id:
    type: string
    inputBinding:
      position: 4
      prefix: --id

outputs:
  vsearch_out1:
    type: File
    outputBinding:
      glob: 'vsearch_out*'
