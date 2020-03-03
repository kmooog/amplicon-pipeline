cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["vsearch", "--sizeout", "--id", "0.97"]
inputs:
  merged_fasta:
    type: File
    inputBinding:
      position: 1
      prefix: --cluster_fast
  out_centroid:
    type: string
    inputBinding:
      position: 3
      prefix: --centroid
  out_msa:
    type: string
    inputBinding:
      position: 3
      prefix: --msaout
outputs:
  centroid: 
    type: File
    outputBinding:
      glob: vsearch_out
  msaout: 
    type: File
    outputBinding:
      glob: vsearch_out.msa
