cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["python", "/root/amplicon-pipeline/script/1-preproccess/uchime_filter.py"]
inputs:
  uchimeout:
    type: File
    inputBinding:
      position: 1
  fasta:
    type: File
    inputBinding:
      position: 2

outputs:
  chimera_filtered: 
    type: File
    outputBinding:
      glob: chimera_filtered.fa