cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["python", "/root/amplicon-pipeline/script/2-analysis/extract_seqs.py"]
inputs:
  merged_fasta:
    type: File
    inputBinding:
      position: 1

outputs:
  centroids_remove_tripleton: 
    type: File
    outputBinding:
      glob: centroids_remove_tripleton.fa
  result_removed3: 
    type: File
    outputBinding:
      glob: result_removed3.csv