cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["python", "/root/amplicon-pipeline/script/python/tax_map.py"]
inputs:
  blast_out:
    type: File
    inputBinding:
      position: 1
  tax_map_db:
    type: File
    inputBinding:
      position: 2

outputs:
  tax_mapped_tsv: 
    type:
      type: array
      items: File
    outputBinding:
      glob: "*_mapped"