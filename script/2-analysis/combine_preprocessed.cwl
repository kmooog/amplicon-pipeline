cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["python", "/root/amplicon-pipeline/script/2-analysis/combine_preprocessed.sh"]
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
      glob: all.fq