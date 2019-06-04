cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["python", "/root/amplicon-pipeline/script/python/remove_singleton.py"]
inputs:
  vsearch_out:
    type: File[]
    inputBinding:
      position: 1
outputs:
  singleton_removed: 
    type: File
    outputBinding:
      glob: singleton_removed.fa